class Snake
  module Model
    class Apple
      attr_reader :cell, :grid
#       attr_accessor :eaten
#       alias eaten? eaten
      
      def initialize(grid)
        @grid = grid
      end
      
      # generates a new snake location and orientation from scratch or via dependency injection of what cell is (for testing purposes)
      def generate(initial_cell: nil)
        @cell = initial_cell || @grid.cells.flatten.reject(&:content).sample
        @cell.content = self
      end
      
      def clear_cell(cell)
        @cell = nil if @cell == cell
      end
    
      # inspect is overridden to prevent printing very long stack traces
      def inspect
        "#{super[0, 120]}... >"
      end
    end
  end
end
