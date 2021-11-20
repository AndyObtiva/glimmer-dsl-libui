require 'glimmer-dsl-libui'
require 'glimmer/data_binding/observer'

require_relative 'snake/presenter/grid'

class Snake
  CELL_SIZE = 15
  SNAKE_MOVE_DELAY = 0.1
  include Glimmer
  
  def initialize
    @game = Model::Game.new
    @grid = Presenter::Grid.new(@game)
    @game.start
    create_gui
    register_observers
  end
  
  def launch
    @main_window.show
  end
  
  def register_observers
    @game.height.times do |row|
      @game.width.times do |column|
        Glimmer::DataBinding::Observer.proc do |new_color|
          @cell_grid[row][column].fill = new_color
        end.observe(@grid.cells[row][column], :color)
      end
    end
    
    Glimmer::DataBinding::Observer.proc do |game_over|
      Glimmer::LibUI.queue_main do
        if game_over
          msg_box('Game Over!', "Score: #{@game.score} | High Score: #{@game.high_score}")
          @game.start
        end
      end
    end.observe(@game, :over)
    
    Glimmer::LibUI.timer(SNAKE_MOVE_DELAY) do
      unless @game.over?
        @game.snake.move
        @main_window.title = "Glimmer Snake (Score: #{@game.score} | High Score: #{@game.high_score})"
      end
    end
  end
  
  def create_gui
    @cell_grid = []
    @main_window = window('Glimmer Snake', @game.width * CELL_SIZE, @game.height * CELL_SIZE) {
      resizable false
      
      vertical_box {
        padded false
        
        @game.height.times do |row|
          @cell_grid << []
          horizontal_box {
            padded false
            
            @game.width.times do |column|
              area {
                @cell_grid.last << square(0, 0, CELL_SIZE) {
                  fill Presenter::Cell::COLOR_CLEAR
                }
                
                on_key_up do |area_key_event|
                  orientation_and_key = [@game.snake.head.orientation, area_key_event[:ext_key]]
                  case orientation_and_key
                  in [:north, :right] | [:east, :down] | [:south, :left] | [:west, :up]
                    @game.snake.turn_right
                  in [:north, :left] | [:west, :down] | [:south, :right] | [:east, :up]
                    @game.snake.turn_left
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
