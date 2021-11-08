require_relative 'grid'

class Snake
  module Model
    class Game
      attr_reader :grid
      
      def initialize
        @grid = Grid.new
      end
      
      def start
      end
    end
  end
end
