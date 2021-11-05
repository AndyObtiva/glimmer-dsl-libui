require 'glimmer-dsl-libui'

require_relative "tic_tac_toe/board"

class TicTacToe
  include Glimmer

  def initialize
    @tic_tac_toe_board = Board.new
  end
  
  def launch
    create_gui
    register_observers
    @main_window.show
  end
  
  def register_observers
    Glimmer::DataBinding::Observer.proc do |game_status|
      display_win_message if game_status == Board::WIN
      display_draw_message if game_status == Board::DRAW
    end.observe(@tic_tac_toe_board, :game_status)
    
    3.times.map do |row|
      3.times.map do |column|
        Glimmer::DataBinding::Observer.proc do |sign|
          @cells[row][column].string = sign
        end.observe(@tic_tac_toe_board[row + 1, column + 1], :sign) # board model is 1-based
      end
    end
  end

  def create_gui
    @main_window = window('Tic-Tac-Toe', 180, 180) {
      resizable false
      
      @cells = []
      vertical_box {
        padded false
        
        3.times.map do |row|
          @cells << []
          horizontal_box {
            padded false
            
            3.times.map do |column|
              area {
                path {
                  square(0, 0, 60)
                  
                  stroke :black, thickness: 2
                }
                text(23, 19) {
                  @cells[row] << string('') {
                    font family: 'Arial', size: 20
                  }
                }
                on_mouse_up do
                  @tic_tac_toe_board.mark(row + 1, column + 1) # board model is 1-based
                end
              }
            end
          }
        end
      }
    }
  end

  def display_win_message
    display_game_over_message("Player #{@tic_tac_toe_board.winning_sign} has won!")
  end

  def display_draw_message
    display_game_over_message("Draw!")
  end

  def display_game_over_message(message_text)
    Glimmer::LibUI.queue_main do
      msg_box('Game Over', message_text)
      @tic_tac_toe_board.reset!
    end
  end
end

TicTacToe.new.launch
