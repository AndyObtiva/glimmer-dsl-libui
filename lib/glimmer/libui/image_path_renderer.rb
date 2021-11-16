module Glimmer
  module LibUI
    class ImagePathRenderer
      include Glimmer
      
      def initialize(area_proxy, shapes)
        @area_proxy = area_proxy
        @shapes = shapes
      end
      
      def render
        work = Proc.new do
          @shapes.each do |shape|
            path {
              rectangle(shape[:x], shape[:y], shape[:width], shape[:height])
    
              fill shape[:color]
            }
          end
        end
        if @area_proxy.nil?
          # Ensure it renders without a parent
          Glimmer::DSL::Engine.add_content(nil, Glimmer::DSL::Libui::ControlExpression.new, 'image', &work)
        else
          work.call
        end
      end
    end
  end
end
