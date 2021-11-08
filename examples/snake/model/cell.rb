class Snake
  module Model
    class Cell
      # orientation is needed for snake occuppied cells (but not apple cells)
      attr_reader :row, :column, :grid
      attr_accessor :content, :orientation
      
      def initialize(grid: ,row: ,column: )
        @row = row
        @column = column
        @grid = grid
      end
      
      def clear
        @content&.clear_cell(self)
        @content = nil
        @orientation = nil
      end
      
      # inspect is overridden to prevent printing very long stack traces
      def inspect
        "#{super[0, 150]}... >"
      end
    end
  end
end
