class Snake
  module Presenter
    class Cell
      COLOR_CLEAR = :white
      COLOR_SNAKE = :green
      COLOR_APPLE = :red
    
      attr_reader :row, :column, :grid
      attr_accessor :color
      
      def initialize(grid: ,row: ,column: )
        @row = row
        @column = column
        @grid = grid
      end
      
      def clear
        self.color = COLOR_CLEAR unless color == COLOR_CLEAR
      end
      
      # inspect is overridden to prevent printing very long stack traces
      def inspect
        "#{super[0, 150]}... >"
      end
    end
  end
end
