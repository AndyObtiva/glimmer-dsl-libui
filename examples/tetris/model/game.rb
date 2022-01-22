# Copyright (c) 2021-2022 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'fileutils'
require 'json'
require 'glimmer/data_binding/observer'
require 'glimmer/config'

require_relative 'block'
require_relative 'tetromino'
require_relative 'past_game'

class Tetris
  module Model
    class Game
      PLAYFIELD_WIDTH = 10
      PLAYFIELD_HEIGHT = 20
      PREVIEW_PLAYFIELD_WIDTH = 4
      PREVIEW_PLAYFIELD_HEIGHT = 2
      SCORE_MULTIPLIER = {1 => 40, 2 => 100, 3 => 300, 4 => 1200}
      
      attr_reader :playfield_width, :playfield_height
      attr_accessor :game_over, :paused, :preview_tetromino, :lines, :score, :level, :high_scores, :beeping, :added_high_score, :show_high_scores, :up_arrow_action
      alias game_over? game_over
      alias paused? paused
      alias beeping? beeping
      alias added_high_score? added_high_score
      
      def initialize(playfield_width = PLAYFIELD_WIDTH, playfield_height = PLAYFIELD_HEIGHT)
        @playfield_width = playfield_width
        @playfield_height = playfield_height
        @high_scores = []
        @show_high_scores = false
        @beeping = true
        @up_arrow_action = :rotate_left
        load_high_scores!
      end
      
      def configure_beeper(&beeper)
        @beeper = beeper
      end
      
      def game_in_progress?
        !game_over? && !paused?
      end
      
      def start!
        self.show_high_scores = false
        self.paused = false
        self.level = 1
        self.score = 0
        self.lines = 0
        reset_playfield
        reset_preview_playfield
        reset_tetrominoes
        preview_next_tetromino!
        consider_adding_tetromino
        self.game_over = false
      end
      alias restart! start!
      
      def game_over!
        add_high_score!
        beep
        self.game_over = true
      end
      
      def clear_high_scores!
        high_scores.clear
        save_high_scores!
      end
      
      def add_high_score!
        self.added_high_score = true
        high_scores.prepend(PastGame.new("Player #{high_scores.count + 1}", score, lines, level))
        save_high_scores!
      end
      
      def save_high_scores!
        high_score_file_content = @high_scores.map {|past_game| past_game.to_a.join("\t") }.join("\n")
        FileUtils.mkdir_p(tetris_dir)
        File.write(tetris_high_score_file, high_score_file_content)
      rescue => e
        # Fail safely by keeping high scores in memory if unable to access disk
        Glimmer::Config.logger.error {"Failed to save high scores in: #{tetris_high_score_file}\n#{e.full_message}"}
      end
      
      def load_high_scores!
        if File.exist?(tetris_high_score_file)
          self.high_scores = File.read(tetris_high_score_file).split("\n").map {|line| PastGame.new(*line.split("\t")) }
        end
      rescue => e
        # Fail safely by keeping high scores in memory if unable to access disk
        Glimmer::Config.logger.error {"Failed to load high scores from: #{tetris_high_score_file}\n#{e.full_message}"}
      end
      
      def tetris_dir
        @tetris_dir ||= File.join(Dir.home, '.glimmer-tetris')
      end
      
      def tetris_high_score_file
        File.join(tetris_dir, "high_scores.txt")
      end
      
      def down!(instant: false)
        return unless game_in_progress?
        current_tetromino.down!(instant: instant)
        game_over! if current_tetromino.row <= 0 && current_tetromino.stopped?
      end
      
      def right!
        return unless game_in_progress?
        current_tetromino.right!
      end
      
      def left!
        return unless game_in_progress?
        current_tetromino.left!
      end
      
      def rotate!(direction)
        return unless game_in_progress?
        current_tetromino.rotate!(direction)
      end
      
      def current_tetromino
        tetrominoes.last
      end
    
      def tetrominoes
        @tetrominoes ||= reset_tetrominoes
      end
      
      # Returns blocks in the playfield
      def playfield
        @playfield ||= @original_playfield = @playfield_height.times.map do
          @playfield_width.times.map do
            Block.new
          end
        end
      end
      
      # Executes a hypothetical scenario without truly changing playfield permanently
      def hypothetical(&block)
        @playfield = hypothetical_playfield
        block.call
        @playfield = @original_playfield
      end
      
      # Returns whether currently executing a hypothetical scenario
      def hypothetical?
        @playfield != @original_playfield
      end
      
      def hypothetical_playfield
        @playfield_height.times.map { |row|
          @playfield_width.times.map { |column|
            playfield[row][column].clone
          }
        }
      end
      
      def preview_playfield
        @preview_playfield ||= PREVIEW_PLAYFIELD_HEIGHT.times.map {|row|
          PREVIEW_PLAYFIELD_WIDTH.times.map {|column|
            Block.new
          }
        }
      end
      
      def preview_next_tetromino!
        self.preview_tetromino = Tetromino.new(self)
      end
      
      def calculate_score!(eliminated_lines)
        new_score = SCORE_MULTIPLIER[eliminated_lines] * (level + 1)
        self.score += new_score
      end
      
      def level_up!
        self.level += 1 if lines >= self.level*10
      end
      
      def delay
        [1.1 - (level.to_i * 0.1), 0.001].max
      end
      
      def beep
        @beeper&.call if beeping
      end
      
      def instant_down_on_up=(value)
        self.up_arrow_action = :instant_down if value
      end
      
      def instant_down_on_up
        self.up_arrow_action == :instant_down
      end
      
      def rotate_right_on_up=(value)
        self.up_arrow_action = :rotate_right if value
      end
      
      def rotate_right_on_up
        self.up_arrow_action == :rotate_right
      end
      
      def rotate_left_on_up=(value)
        self.up_arrow_action = :rotate_left if value
      end
      
      def rotate_left_on_up
        self.up_arrow_action == :rotate_left
      end
      
      def reset_tetrominoes
        @tetrominoes = []
      end
      
      def reset_playfield
        playfield.each do |row|
          row.each do |block|
            block.clear
          end
        end
      end
      
      def reset_preview_playfield
        preview_playfield.each do |row|
          row.each do |block|
            block.clear
          end
        end
      end
      
      def consider_adding_tetromino
        if tetrominoes.empty? || current_tetromino.stopped?
          preview_tetromino.launch!
          preview_next_tetromino!
        end
      end
      
      def consider_eliminating_lines
        eliminated_lines = 0
        playfield.each_with_index do |row, playfield_row|
          if row.all? {|block| !block.clear?}
            eliminated_lines += 1
            shift_blocks_down_above_row(playfield_row)
          end
        end
        if eliminated_lines > 0
          beep
          self.lines += eliminated_lines
          level_up!
          calculate_score!(eliminated_lines)
        end
      end
            
      def playfield_remaining_heights(tetromino = nil)
        @playfield_width.times.map do |playfield_column|
          bottom_most_block = tetromino.bottom_most_block_for_column(playfield_column)
          (playfield.each_with_index.detect do |row, playfield_row|
            !row[playfield_column].clear? &&
            (
              tetromino.nil? ||
              bottom_most_block.nil? ||
              (playfield_row > tetromino.row + bottom_most_block[:row_index])
            )
          end || [nil, @playfield_height])[1]
        end.to_a
      end
      
      private
      
      def shift_blocks_down_above_row(row)
        row.downto(0) do |playfield_row|
           playfield[playfield_row].each_with_index do |block, playfield_column|
             previous_row = playfield[playfield_row - 1]
             previous_block = previous_row[playfield_column]
             block.color = previous_block.color unless block.color == previous_block.color
           end
        end
        playfield[0].each(&:clear)
      end
      
    end
  
  end

end
