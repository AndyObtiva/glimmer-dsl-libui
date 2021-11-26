require 'glimmer'
require_relative '../model/game'
require_relative 'cell'

class Snake
  module Presenter
    class Grid
      include Glimmer
      
      attr_reader :game, :cells
      
      def initialize(game = Model::Game.new)
        @game = game
        @cells = @game.height.times.map do |row|
          @game.width.times.map do |column|
            Cell.new(grid: self, row: row, column: column)
          end
        end
        observe(@game.snake, :vertebrae) do |new_vertebrae|
          occupied_snake_positions = @game.snake.vertebrae.map {|v| [v.row, v.column]}
          @cells.each_with_index do |row_cells, row|
            row_cells.each_with_index do |cell, column|
              if [@game.apple.row, @game.apple.column] == [row, column]
                cell.color = Cell::COLOR_APPLE
              elsif occupied_snake_positions.include?([row, column])
                cell.color = Cell::COLOR_SNAKE
              else
                cell.clear
              end
            end
          end
        end
      end
      
      def clear
        @cells.each do |row_cells|
          row_cells.each do |cell|
            cell.clear
          end
        end
      end
      
      # inspect is overridden to prevent printing very long stack traces
      def inspect
        "#{super[0, 75]}... >"
      end
    end
  end
end
