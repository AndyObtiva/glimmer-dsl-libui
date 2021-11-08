class Snake
  module Model
    class Cell
      attr_reader :grid, :row, :column
      attr_accessor :content
      
      def initialize(grid: , row: , column: )
        @grid = grid
        @row = row
        @column = column
      end
      
      def clear
        @content&.clear_cell(self)
        @content = nil
      end
      
      # inspect is overridden to prevent printing very long stack traces
      def inspect
        "#{super[0, 60]}... >"
      end
    end
  end
end
