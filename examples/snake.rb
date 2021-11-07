require 'glimmer-dsl-libui'

class Snake
  # TODO test-drive the model logic
  module Model
    class Cell
      attr_accessor :x, :y, :occupied_by # :snake or :apple (nil means unoccupied)
    end
    
    class Grid
      attr_accessor :cells # rows of columns
    end
    
    class Snake
      attr_accessor :head_cell, :turn_cells, :cells, :length, :collided
      alias collided? collided
      
      def move_by_one_cell
      end
      
      def turn_left
      end
      
      def turn_right
      end
      
      def grow
      end
    end
    
    class Apple
      attr_accessor :cell, :eaten # a cell object
      alias eaten? eaten
      
      def generate
      end
    end
  end
end

Snake.new.launch
