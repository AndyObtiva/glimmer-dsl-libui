# Copyright (c) 2021-2025 Andy Maleh
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

require_relative 'cell'

class TicTacToe
  class Board
    DRAW = :draw
    IN_PROGRESS = :in_progress
    WIN = :win
    attr :winning_sign
    attr_accessor :game_status
  
    def initialize
      @sign_state_machine = {nil => "X", "X" => "O", "O" => "X"}
      build_grid
      @winning_sign = Cell::EMPTY
      @game_status = IN_PROGRESS
    end
  
    #row and column numbers are 1-based
    def mark(row, column)
      if self[row, column].empty
        self[row, column].mark(current_sign)
        game_over? #updates winning sign
      end
    end
  
    def current_sign
      @current_sign = @sign_state_machine[@current_sign]
    end
  
    def [](row, column)
      @grid[row-1][column-1]
    end
  
    def game_over?
       win? or draw?
    end
  
    def win?
      win = (row_win? or column_win? or diagonal_win?)
      self.game_status=WIN if win
      win
    end
  
    def reset!
      (1..3).each do |row|
        (1..3).each do |column|
          self[row, column].reset!
        end
      end
      @winning_sign = Cell::EMPTY
      @current_sign = nil
      self.game_status=IN_PROGRESS
    end
  
    private
  
    def build_grid
      @grid = []
      3.times do |row_index| #0-based
        @grid << []
        3.times { @grid[row_index] << Cell.new }
      end
    end
  
    def row_win?
      (1..3).each do |row|
        if row_has_same_sign(row)
          @winning_sign = self[row, 1].sign
          return true
        end
      end
      false
    end
  
    def column_win?
      (1..3).each do |column|
        if column_has_same_sign(column)
          @winning_sign = self[1, column].sign
          return true
        end
      end
      false
    end
  
    #needs refactoring if we ever decide to make the board size dynamic
    def diagonal_win?
      if (self[1, 1].sign == self[2, 2].sign) and (self[2, 2].sign == self[3, 3].sign) and self[1, 1].marked
        @winning_sign = self[1, 1].sign
        return true
      end
      if (self[3, 1].sign == self[2, 2].sign) and (self[2, 2].sign == self[1, 3].sign) and self[3, 1].marked
        @winning_sign = self[3, 1].sign
        return true
      end
      false
    end
  
    def draw?
      @board_full = true
      3.times do |x|
        3.times do |y|
          @board_full = false if self[x, y].empty
        end
      end
      self.game_status = DRAW if @board_full
      @board_full
    end
  
    def row_has_same_sign(number)
      row_sign = self[number, 1].sign
      [2, 3].each do |column|
        return false unless row_sign == (self[number, column].sign)
      end
      true if self[number, 1].marked
    end
  
    def column_has_same_sign(number)
      column_sign = self[1, number].sign
      [2, 3].each do |row|
        return false unless column_sign == (self[row, number].sign)
      end
      true if self[1, number].marked
    end
  
  end
end
