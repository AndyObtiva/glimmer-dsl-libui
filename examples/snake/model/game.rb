require_relative 'snake'
require_relative 'apple'

class Snake
  module Model
    class Game
      WIDTH_DEFAULT = 40
      HEIGHT_DEFAULT = 40
      
      attr_reader :width, :height
      attr_accessor :snake, :apple, :over, :score
      alias over? over
      # TODO implement scoring on snake eating apples
      
      def initialize(width = WIDTH_DEFAULT, height = HEIGHT_DEFAULT)
        @width = width
        @height = height
        @snake = Snake.new(self)
        @apple = Apple.new(self)
      end
      
      def start
        self.over = false
        self.score = 0
        self.snake.generate
        self.apple.generate
      end
      
      # inspect is overridden to prevent printing very long stack traces
      def inspect
        "#{super[0, 75]}... >"
      end
    end
  end
end
