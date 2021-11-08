class Snake
  module Model
    class Snake
      ORIENTATIONS = %i[north east south west]
#       attr_accessor :collided
#       alias collided? collided
      
      # cells are from tail to head
      # turn cells are from tail to head
      attr_reader :head_cell, :cells, :turn_cells, :orientation, :grid
      
      def initialize(grid)
        @grid = grid
      end
      
      # generates a new snake location and orientation from scratch or via dependency injection of what head_cell and orientation are (for testing purposes)
      def generate(initial_head_cell: nil, initial_orientation: nil)
        @head_cell = initial_head_cell || @grid.cells.flatten.reject(&:content).sample
        @head_cell.content = self
        @cells = [@head_cell]
        @turn_cells = []
        @orientation = initial_orientation || ORIENTATIONS.sample
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
        case @orientation
        when :east
          previous_head_cell = @head_cell
          @head_cell.clear
          @head_cell = @grid.cells[previous_head_cell.row][previous_head_cell.column + 1]
          @cells = [@head_cell]
          # TODO handle turn cells and all cells correctly
        end
      end
      
      def turn_left
      end
      
      def turn_right
      end
      
      def grow
      end
      
      # inspect is overridden to prevent printing very long stack traces
      def inspect
        "#{super[0, 150]}... >"
      end
    end
  end
end
