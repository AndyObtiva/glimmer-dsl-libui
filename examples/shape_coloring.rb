require 'glimmer-dsl-libui'

class ShapeColoring
  include Glimmer::LibUI::Application
  
  COLORS = %i[violet indigo blue green yellow orange red]
  
  body {
    window('Shape Coloring') {
      margined true

      horizontal_box {
        area {
          rectangle(0, 0, 20, 20) { |shape|
            fill :red
            
            on_mouse_up do |area_mouse_event|
              shape.fill = COLORS.sample
            end
          }
        }
      }
    }
  }
end

ShapeColoring.launch
