class Snake
  module Model
    class Snake
      ORIENTATIONS = %i[north east south west]
#       attr_accessor :collided
#       alias collided? collided
      
      # cells are from tail to head
      # turn cells are from tail to head
      attr_accessor :cells, :turn_cells, :orientation, :grid
      
      def initialize(grid)
        @grid = grid
      end
      
      # generates a new snake location and orientation from scratch or via dependency injection of what head_cell and orientation are (for testing purposes)
      def generate(initial_cell: nil, initial_orientation: nil)
        initial_cell = initial_cell || @grid.cells.flatten.reject(&:content).sample
        initial_cell.content = self
        self.cells = [initial_cell]
        self.turn_cells = []
        self.orientation = initial_orientation || ORIENTATIONS.sample
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
        old_cells = @cells.map(&:dup)
        @cells = @cells.map do |cell|
          cell_orientation = cell.orientation
          cell.clear
          new_cell = case cell_orientation
          when :east
            @grid.cells[cell.row][(cell.column + 1) % @grid.width]
          when :west
            @grid.cells[cell.row][(cell.column - 1) % @grid.width]
          when :south
            @grid.cells[(cell.row + 1) % @grid.height][cell.column]
          when :north
            @grid.cells[(cell.row - 1) % @grid.height][cell.column]
          end
          new_cell.orientation = cell_orientation
          new_cell
        end
        # TODO handle turn cells
      end
      
      def turn_left
      end
      
      def turn_right
        case @orientation
        when :east
          @cells.last.orientation = self.orientation = :south
        when :west
          @cells.last.orientation = self.orientation = :north
        when :south
          @cells.last.orientation = self.orientation = :west
        when :north
          @cells.last.orientation = self.orientation = :east
        end
        @turn_cells << @cells.last
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
