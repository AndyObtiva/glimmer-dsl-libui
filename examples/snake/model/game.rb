require 'fileutils'

require_relative 'snake'
require_relative 'apple'

class Snake
  module Model
    class Game
      WIDTH_DEFAULT = 20
      HEIGHT_DEFAULT = 20
      FILE_HIGH_SCORE = File.expand_path(File.join(Dir.home, '.glimmer-snake'))
      
      attr_reader :width, :height
      attr_accessor :snake, :apple, :over, :score, :high_score, :paused
      alias over? over
      alias paused? paused
      
      def initialize(width = WIDTH_DEFAULT, height = HEIGHT_DEFAULT)
        @width = width
        @height = height
        @snake = Snake.new(self)
        @apple = Apple.new(self)
        FileUtils.touch(FILE_HIGH_SCORE)
        @high_score = File.read(FILE_HIGH_SCORE).to_i rescue 0
      end
      
      def score=(new_score)
        @score = new_score
        self.high_score = @score if @score > @high_score
      end
      
      def high_score=(new_high_score)
        @high_score = new_high_score
        File.write(FILE_HIGH_SCORE, @high_score.to_s)
      rescue => e
        puts e.full_message
      end
      
      def start
        self.over = false
        self.score = 0
        self.snake.generate
        self.apple.generate
      end
      
      def pause
        self.paused = true
      end
      
      def resume
        self.paused = false
      end
      
      def toggle_pause
        unless paused?
          pause
        else
          resume
        end
      end
      
      # inspect is overridden to prevent printing very long stack traces
      def inspect
        "#{super[0, 75]}... >"
      end
    end
  end
end
