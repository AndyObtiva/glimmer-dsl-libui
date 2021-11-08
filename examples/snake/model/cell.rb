class Snake
  module Model
    class Cell
      attr_reader :grid, :row, :column, :content
      
      def initialize(grid: , row: , column: )
        @grid = grid
        @row = row
        @column = column
      end
    end
  end
end
