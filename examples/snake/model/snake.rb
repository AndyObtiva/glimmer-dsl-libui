class Snake
  module Model
    class Snake
      ORIENTATIONS = %i[north east south west]
#       attr_accessor :collided
#       alias collided? collided
      
      # cells are from tail to head
      # turn cells are from tail to head
      attr_reader :cells, :turn_cells, :orientation, :grid
      
      def initialize(grid)
        @grid = grid
      end
      
      # generates a new snake location and orientation from scratch or via dependency injection of what head_cell and orientation are (for testing purposes)
      def generate(initial_cell: nil, initial_orientation: nil)
        initial_cell = initial_cell || @grid.cells.flatten.reject(&:content).sample
        initial_cell.content = self
        @cells = [initial_cell]
        @turn_cells = []
        @orientation = initial_orientation || ORIENTATIONS.sample
        initial_cell.orientation = @orientation
      end
      
      def length
        @cells.length
      end
      
      def clear_cell(cell)
        @cells.delete(cell)
        @turn_cells.delete(cell)
      end
      
      def move_by_one_cell
        @cells = @cells.map do |cell|
          cell_orientation = cell.orientation
          cell.clear
          case cell_orientation
          when :east
            @grid.cells[cell.row][(cell.column + 1) % @grid.width]
          end
        end
        # TODO handle turn cells
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
