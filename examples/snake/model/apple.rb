class Snake
  module Model
    class Apple
      attr_accessor :cell, :eaten # a cell object
      alias eaten? eaten
      
      def generate
      end
    end
  end
end
