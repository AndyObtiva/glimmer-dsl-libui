require_relative 'cell'

class Snake
  module Model
    class Grid
      WIDTH_DEFAULT = 40
      HEIGHT_DEFAULT = 40
      
      attr_reader :width, :height, :cells
      
      def initialize(width = WIDTH_DEFAULT, height = HEIGHT_DEFAULT)
        @width = width
        @height = height
        @cells = @height.times.map do |row|
          @width.times.map do |column|
            Cell.new(grid: self, row: row, column: column)
          end
        end
      end
    end
  end
end
