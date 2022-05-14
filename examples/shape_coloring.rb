require 'glimmer-dsl-libui'

class ShapeColoring
  include Glimmer::LibUI::Application
  
  COLORS = %i[violet indigo blue green yellow orange red]
  
  body {
    window('Shape Coloring') {
      margined false

      horizontal_box {
        area {
          rectangle(0, 0, 400, 300) { # background shape
            fill :white
          }
          colorable(:rectangle, 10, 10, 40, 20) { |shape|
            fill COLORS.sample
          }
          colorable(:square, 70, 20, 20) { |shape|
            fill COLORS.sample
          }
          colorable(:circle, 60, 60, 20, 20) { |shape|
            fill COLORS.sample
          }
          colorable(:arc, 90, 70, 40, 0, 145) { |shape|
            fill COLORS.sample
          }
          colorable(:polygon, 120, 10, 120, 50, 150, 10, 150, 50) {
            fill COLORS.sample
          }
        }
      }
    }
  }
  
  def colorable(shape_symbol, *args, &content)
    send(shape_symbol, *args) do |shape|
      on_mouse_up do |area_mouse_event|
        shape.fill = COLORS.sample
      end
      
      content.call(shape)
    end
  end
end

ShapeColoring.launch
