require 'glimmer-dsl-libui'

class ShapeColoring
  include Glimmer::LibUI::Application
  
  COLOR_SELECTION = Glimmer::LibUI.interpret_color(:red)
  
  before_body {
    @shapes = []
  }
  
  body {
    window('Shape Coloring', 200, 200) {
      margined false
      
      grid {
        label("Click a shape to select and\nchange color via color button") {
          left 0
          top 0
          hexpand true
          halign :center
          vexpand false
        }
        
        color_button { |cb|
          left 0
          top 1
          hexpand true
          vexpand false
          
          on_changed do
            @selected_shape&.fill = cb.color
          end
        }
      
        area {
          left 0
          top 2
          hexpand true
          vexpand true
          
          rectangle(0, 0, 600, 400) { # background shape
            fill :white
          }
          
          @shapes << colorable(:rectangle, 20, 20, 40, 20) {
            fill :lime
          }
          
          @shapes << colorable(:square, 80, 20, 20) {
            fill :blue
          }
          
          @shapes << colorable(:circle, 75, 70, 20) {
            fill :green
          }
          
          @shapes << colorable(:arc, 120, 70, 40, 0, 145) {
            fill :orange
          }
          
          @shapes << colorable(:polygon, 120, 10, 120, 50, 150, 10, 150, 50) {
            fill :cyan
          }
          
          @shapes << colorable(:polybezier, 20, 40,
                     30, 100, 50, 80, 80, 110,
                     40, 120, 20, 120, 30, 91) {
            fill :pink
          }
        }
      }
    }
  }
  
  def colorable(shape_symbol, *args, &content)
    send(shape_symbol, *args) do |shape|
      on_mouse_up do |area_mouse_event|
        old_stroke = Glimmer::LibUI.interpret_color(shape.stroke).slice(:r, :g, :b)
        @shapes.each {|sh| sh.stroke = nil}
        @selected_shape = nil
        unless old_stroke == COLOR_SELECTION
          shape.stroke = COLOR_SELECTION.merge(thickness: 2)
          @selected_shape = shape
        end
      end
      
      content.call(shape)
    end
  end
end

ShapeColoring.launch
