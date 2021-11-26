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
    observe(@game, :over) do |game_over|
      Glimmer::LibUI.queue_main do
        if game_over
          msg_box('Game Over!', "Score: #{@game.score} | High Score: #{@game.high_score}")
          @game.start
        end
      end
    end
    
    Glimmer::LibUI.timer(SNAKE_MOVE_DELAY) do
      @game.snake.move unless @game.over?
    end
  end
  
  def create_gui
    @main_window = window {
      # data-bind window title to game score, converting it to a title string on read from the model
      title <= [@game, :score, on_read: -> (score) {"Glimmer Snake (Score: #{@game.score})"}]
      content_size @game.width * CELL_SIZE, @game.height * CELL_SIZE
      resizable false
      
      vertical_box {
        padded false
        
        @game.height.times do |row|
          horizontal_box {
            padded false
            
            @game.width.times do |column|
              area {
                square(0, 0, CELL_SIZE) {
                  fill <= [@grid.cells[row][column], :color] # data-bind square fill to grid cell color
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
