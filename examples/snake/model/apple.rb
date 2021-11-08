class Snake
  module Model
    class Apple
      attr_reader :game
      attr_accessor :row, :column
      
      def initialize(game)
        @game = game
      end
      
      # generates a new location from scratch or via dependency injection of what cell is (for testing purposes)
      def generate(initial_row: nil, initial_column: nil)
        if initial_row && initial_column
          self.row, self.column = initial_row, initial_column
        else
          self.row, self.column = @game.height.times.zip(@game.width.times).reject do |row, column|
            @game.snake.vertebrae.map {|v| [v.row, v.column]}.include?([row, column])
          end.sample
        end
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
