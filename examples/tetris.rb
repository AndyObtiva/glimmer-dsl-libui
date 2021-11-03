# Copyright (c) 2021 Andy Maleh
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

require 'glimmer-dsl-libui'

require_relative 'tetris/model/game'

class Tetris
  include Glimmer
  
  BLOCK_SIZE = 25
  BEVEL_CONSTANT = 20
  COLOR_GRAY = {r: 192, g: 192, b: 192}
    
  attr_reader :game
  
  def initialize
    @game = Model::Game.new
    create_gui
    register_observers
  end
  
  def launch
    @game.start!
    @main_window.show
  end
  
  def create_gui
    @main_window = window('Glimmer Tetris', Model::Game::PLAYFIELD_WIDTH * BLOCK_SIZE, Model::Game::PLAYFIELD_HEIGHT * BLOCK_SIZE) {
      playfield(playfield_width: Model::Game::PLAYFIELD_WIDTH, playfield_height: Model::Game::PLAYFIELD_HEIGHT, block_size: BLOCK_SIZE)
    }
  end
  
  def register_observers
    Glimmer::DataBinding::Observer.proc do |game_over|
      if game_over
        show_game_over_dialog
      else
        start_moving_tetrominos_down
      end
    end.observe(@game, :game_over)
    
    Model::Game::PLAYFIELD_HEIGHT.times do |row|
      Model::Game::PLAYFIELD_HEIGHT.times do |column|
        Glimmer::DataBinding::Observer.proc do |new_color|
          color = Glimmer::LibUI.interpret_color(new_color)
          block = @blocks[row][column]
          @playfield.pause_auto_redraw # performance optimization to prevent multiple unnecessary redraws
          block[:background_square].fill = color
          block[:top_bevel_edge].fill = {r: color[:r] + 4*BEVEL_CONSTANT, g: color[:g] + 4*BEVEL_CONSTANT, b: color[:b] + 4*BEVEL_CONSTANT}
          block[:right_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
          block[:bottom_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
          block[:left_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
          @playfield.resume_auto_redraw
          block[:border_square].stroke = new_color == Model::Block::COLOR_CLEAR ? COLOR_GRAY : color
        end.observe(@game.playfield[row][column], :color)
      end
    end
  end
  
  def playfield(playfield_width: , playfield_height: , block_size: )
    @playfield = area {
      @blocks = playfield_height.times.map do |row|
        playfield_width.times.map do |column|
          block(row: row, column: column, block_size: block_size)
        end
      end
      
      on_key_down do |key_event|
        case key_event
        in ext_key: :down
          game.down!
        in ext_key: :up
          case game.up_arrow_action
          when :instant_down
            game.down!(instant: true)
          when :rotate_right
            game.rotate!(:right)
          when :rotate_left
            game.rotate!(:left)
          end
        in ext_key: :left
          game.left!
        in ext_key: :right
          game.right!
        in modifier: :shift
          game.rotate!(:right)
        in modifier: :control
          game.rotate!(:left)
        else
          # Do Nothing
        end
      end
    }
  end
  
  def block(row: , column: , block_size: )
    block = {}
    bevel_pixel_size = 0.16 * block_size.to_f
    color = Glimmer::LibUI.interpret_color(Model::Block::COLOR_CLEAR)
    x = column * block_size
    y = row * block_size
    block[:background_square] = path {
      square(x, y, block_size)
      
      fill Model::Block::COLOR_CLEAR
    }
    block[:top_bevel_edge] = path {
      polygon(x, y, x + block_size, y, x + block_size - bevel_pixel_size, y + bevel_pixel_size, x + bevel_pixel_size, y + bevel_pixel_size)

      fill r: color[:r] + 4*BEVEL_CONSTANT, g: color[:g] + 4*BEVEL_CONSTANT, b: color[:b] + 4*BEVEL_CONSTANT
    }
    block[:right_bevel_edge] = path {
      polygon(x + block_size, y, x + block_size - bevel_pixel_size, y + bevel_pixel_size, x + block_size - bevel_pixel_size, y + block_size - bevel_pixel_size, x + block_size, y + block_size)

      fill r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT
    }
    block[:bottom_bevel_edge] = path {
      polygon(x + block_size, y + block_size, x, y + block_size, x + bevel_pixel_size, y + block_size - bevel_pixel_size, x + block_size - bevel_pixel_size, y + block_size - bevel_pixel_size)

      fill r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT
    }
    block[:left_bevel_edge] = path {
      polygon(x, y, x, y + block_size, x + bevel_pixel_size, y + block_size - bevel_pixel_size, x + bevel_pixel_size, y + bevel_pixel_size)

      fill r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT
    }
    block[:border_square] = path {
      square(x, y, block_size)

      stroke COLOR_GRAY
    }
    block
  end
  
  def start_moving_tetrominos_down
    Glimmer::LibUI.timer(@game.delay) do
      @game.down! if !@game.game_over? && !@game.paused?
    end
  end
  
  def show_game_over_dialog
    msg_box('Game Over', "Score: #{@game.high_scores.first.score}")
  end
end

Tetris.new.launch
