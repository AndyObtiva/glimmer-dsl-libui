class Snake
  module Model
    class Apple
      attr_reader :grid, :cell
#       attr_accessor :eaten
#       alias eaten? eaten
      
      def initialize(grid)
        @grid = grid
      end
      
      def generate
        @cell = @grid.cells.flatten.reject(&:content).sample
        @cell.content = self
      end
      
      def clear_cell(cell)
        @cell = nil if @cell == cell
      end
    
      # inspect is overridden to prevent printing very long stack traces
      def inspect
        "#{super[0, 60]}... >"
      end
    end
  end
end
