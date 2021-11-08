class Snake
  module Model
    class Vertebra
      ORIENTATIONS = %i[north east south west]
      # orientation is needed for snake occuppied cells (but not apple cells)
      attr_reader :snake
      attr_accessor :row, :column, :orientation
      
      def initialize(snake: , row: , column: , orientation: )
        @row = row || rand(snake.game.height)
        @column = column || rand(snake.game.width)
        @orientation = orientation || ORIENTATIONS.sample
        @snake = snake
      end
      
      # inspect is overridden to prevent printing very long stack traces
      def inspect
        "#{super[0, 150]}... >"
      end
    end
  end
end
