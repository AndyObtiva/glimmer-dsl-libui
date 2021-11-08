class Snake
  module Model
    class Apple
      attr_reader :game
      attr_accessor :row, :column
#       attr_accessor :eaten
#       alias eaten? eaten
      
      def initialize(game)
        @game = game
      end
      
      # generates a new location from scratch or via dependency injection of what cell is (for testing purposes)
      def generate(initial_row: nil, initial_column: nil)
        self.row = initial_row || rand(@game.height)
        self.column = initial_column || rand(@game.width)
      end
      
      def remove
        self.row = nil
        self.column = nil
      end
    
      # inspect is overridden to prevent printing very long stack traces
      def inspect
        "#{super[0, 120]}... >"
      end
    end
  end
end
