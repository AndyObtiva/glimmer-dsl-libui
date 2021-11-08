require_relative 'grid'
require_relative 'snake'
require_relative 'apple'

class Snake
  module Model
    class Game
      attr_reader :snake, :apple, :grid
      
      def initialize
        @grid = Grid.new
      end
      
      def start
        @grid.clear
        @snake = Snake.new(@grid)
        @snake.generate
        @apple = Apple.new(@grid)
        @apple.generate
      end
      
      # inspect is overridden to prevent printing very long stack traces
      def inspect
        "#{super[0, 75]}... >"
      end
    end
  end
end
