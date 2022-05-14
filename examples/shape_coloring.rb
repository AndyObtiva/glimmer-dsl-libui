require 'glimmer-dsl-libui'

class ShapeColoring
  include Glimmer::LibUI::Application
  
  COLORS = %i[purple blue green orange red]
  
  body {
    window('Shape Coloring') {
      margined false
      
      grid {
        label("Color by Clicking a Shape") {
          left 0
          top 0
          hexpand true
          halign :center
          vexpand false
        }
      
        area {
          left 0
          top 1
          hexpand true
          vexpand true
          
          rectangle(0, 0, 600, 400) { # background shape
            fill :white
          }
          
          colorable(:rectangle, 20, 20, 40, 20) { |shape|
            fill COLORS.sample
          }
          
          colorable(:square, 80, 20, 20) { |shape|
            fill COLORS.sample
          }
          
          colorable(:circle, 75, 70, 20, 20) { |shape|
            fill COLORS.sample
          }
          
          colorable(:arc, 120, 70, 40, 0, 145) { |shape|
            fill COLORS.sample
          }
          
          colorable(:polygon, 120, 10, 120, 50, 150, 10, 150, 50) {
            fill COLORS.sample
          }
          
          colorable(:polybezier, 10, 40,
                     20, 70, 10, 80, 10, 51,
                     20, 100, 40, 80, 70, 110,
                     30, 120, 10, 120, 10, 91) {
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
