require_relative 'vertebra'
  
class Snake
  module Model
    class Snake
      SCORE_EAT_APPLE = 50
      RIGHT_TURN_MAP = {
        north: :east,
        east: :south,
        south: :west,
        west: :north
      }
      LEFT_TURN_MAP = RIGHT_TURN_MAP.invert
      
      attr_accessor :collided
      alias collided? collided
      
      attr_reader :game
      # vertebrae and joins are ordered from tail to head
      attr_accessor :vertebrae
      
      def initialize(game)
        @game = game
      end
      
      # generates a new snake location and orientation from scratch or via dependency injection of what head_cell and orientation are (for testing purposes)
      def generate(initial_row: nil, initial_column: nil, initial_orientation: nil)
        self.collided = false
        initial_vertebra = Vertebra.new(snake: self, row: initial_row, column: initial_column, orientation: initial_orientation)
        self.vertebrae = [initial_vertebra]
      end
      
      def length
        @vertebrae.length
      end
      
      def head
        @vertebrae.last
      end
      
      def tail
        @vertebrae.first
      end
      
      def remove
        self.vertebrae.clear
        self.joins.clear
      end
      
      def turn_right
        head.orientation = RIGHT_TURN_MAP[head.orientation]
      end
      
      def turn_left
        head.orientation = LEFT_TURN_MAP[head.orientation]
      end
      
      def move
        create_new_head
        remove_old_tail
        if detect_collision?
          collide_and_die
        else
          append_new_head
          eat_apple if detect_apple?
        end
      end
      
      def remove_old_tail
        @old_tail = tail.dup # save in case of growing and keeping old tail
        @vertebrae.delete(tail)
      end
      
      def create_new_head
        @new_head = head.dup
        case head.orientation
        when :east
          @new_head.column = (@new_head.column + 1) % @game.width
        when :west
          @new_head.column = (@new_head.column - 1) % @game.width
        when :south
          @new_head.row = (@new_head.row + 1) % @game.height
        when :north
          @new_head.row = (@new_head.row - 1) % @game.height
        end
      end
      
      def append_new_head
        @vertebrae.append(@new_head)
      end
      
      def detect_collision?
        @vertebrae.map {|v| [v.row, v.column]}.include?([@new_head.row, @new_head.column])
      end
      
      def collide_and_die
        self.collided = true
        @game.over = true
      end
      
      def detect_apple?
        head.row == @game.apple.row && head.column == @game.apple.column
      end
      
      def eat_apple
        grow
        @game.apple.generate
      end
      
      def grow
        @game.score += SCORE_EAT_APPLE
        @vertebrae.prepend(@old_tail)
      end
      
      # inspect is overridden to prevent printing very long stack traces
      def inspect
        "#{super[0, 150]}... >"
      end
    end
  end
end
