require 'glimmer-dsl-libui'
require 'glimmer/data_binding/observer'

require_relative 'snake/presenter/grid'

class Snake
  CELL_SIZE = 25
  include Glimmer
  
  def initialize
    @grid = Presenter::Grid.new
    @grid.game.start
    create_gui
    register_observers
  end
  
  def launch
    @main_window.show
  end
  
  def register_observers
    @grid.game.height.times do |row|
      @grid.game.width.times do |column|
        Glimmer::DataBinding::Observer.proc do |new_color|
          @cell_grid[row][column].fill = new_color
        end.observe(@grid.cells[row][column], :color)
      end
    end
    Glimmer::LibUI.timer(0.1) do
      @grid.game.snake.move
    end
  end
  
  def create_gui
    @cell_grid = []
    @main_window = window('Glimmer Snake', @grid.game.width * CELL_SIZE, @grid.game.height * CELL_SIZE) {
      vertical_box {
        padded false
        
        @grid.game.height.times do |row|
          @cell_grid << []
          horizontal_box {
            padded false
            
            @grid.game.width.times do |column|
              area {
                @cell_grid.last << path {
                  square(0, 0, CELL_SIZE)
                  
                  fill Presenter::Cell::COLOR_CLEAR
                }
                
                on_key_up do |area_key_event|
                  orientation_and_key = [@grid.game.snake.head.orientation, area_key_event[:ext_key]]
                  case orientation_and_key
                  in [:north, :right] | [:east, :down] | [:south, :left] | [:west, :up]
                    @grid.game.snake.turn_right
                  in [:north, :left] | [:west, :down] | [:south, :right] | [:east, :up]
                    @grid.game.snake.turn_left
                  in [*, :right]
                    @grid.game.snake.turn_right
                  in [*, :left]
                    @grid.game.snake.turn_left
                  else
                    # No Op
                  end
                end
              }
            end
          }
        end
      }
    }
  end
end

Snake.new.launch
