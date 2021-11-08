class Snake
  module Model
    class Snake
      ORIENTATIONS = %i[north east south west]
#       attr_accessor :collided
#       alias collided? collided
      
      # cells are from tail to head
      # turn cells are from tail to head
      attr_reader :grid, :head_cell, :cells, :turn_cells, :orientation
      
      def initialize(grid)
        @grid = grid
      end
      
      def generate
        @head_cell = @grid.cells.flatten.reject(&:content).sample
        @head_cell.content = self
        @cells = [@head_cell]
        @turn_cells = []
        @orientation = ORIENTATIONS.sample
      end
      
      def length
        @cells.length
      end
      
      def clear_cell(cell)
        @head_cell = nil if @head_cell == cell
        @turn_cells.delete(cell)
        @cells.delete(cell)
      end
      
      def move_by_one_cell
      end
      
      def turn_left
      end
      
      def turn_right
      end
      
      def grow
      end
      
      # inspect is overridden to prevent printing very long stack traces
      def inspect
        "#{super[0, 60]}... >"
      end
    end
  end
end
