require_relative 'snake'
require_relative 'apple'

class Snake
  module Model
    class Game
      WIDTH_DEFAULT = 40
      HEIGHT_DEFAULT = 40
      
      attr_reader :width, :height
      attr_accessor :snake, :apple
      
      def initialize(width = WIDTH_DEFAULT, height = HEIGHT_DEFAULT)
        @width = width
        @height = height
      end
      
      def start
        self.snake = Snake.new(self)
        self.snake.generate
        self.apple = Apple.new(self)
        self.apple.generate
      end
      
      # inspect is overridden to prevent printing very long stack traces
      def inspect
        "#{super[0, 75]}... >"
      end
    end
  end
end
