require 'glimmer-dsl-libui'

include Glimmer

# Graphical push button built with vector graphics on top of area
# text_x and text_y are the offset of the button text in releation to its top-left corner
# When text_x, text_y are left nil, the text is automatically centered in the button area.
# Sometimes, the centering calculation is not perfect due to using a custom font, so
# in that case, pass in text_x, and text_y manually
def push_button(button_text,
                width: 80, height: 30, font_descriptor: {}, color: :white,
                text_x: nil, text_y: nil, border_color: {r: 201, g: 201, b: 201},
                &content)
  color = Glimmer::LibUI.interpret_color(color)
  button_parts = {}
  area { |a|
    button_parts[:background_rectangle] = rectangle(1, 1, width, height) {
      fill color
    }
    
    button_parts[:border_rectangle] = rectangle(1, 1, width, height) {
      stroke border_color
    }
    
    text_height = (font_descriptor[:size] || 12) * 0.75
    text_width = (text_height * button_text.size) * 0.75
    text_x ||= (width - text_width) / 2.0
    text_y ||= (height - 4 - text_height) / 2.0
    text(text_x, text_y, width) {
      button_parts[:button_string] = string(button_text) {
        font font_descriptor
      }
    }
    
    on_mouse_down do
      button_parts[:background_rectangle].fill = {x0: 0, y0: 0, x1: 0, y1: height, stops: [{pos: 0, r: 72, g: 146, b: 247}, {pos: 1, r: 12, g: 85, b: 214}]}
      button_parts[:button_string].color = :white
    end
    
    on_mouse_up do
      button_parts[:background_rectangle].fill = color
      button_parts[:button_string].color = :black
    end
    
    content.call(a)
  }
end

class AreaBasedCustomControls
  include Glimmer
  
  attr_accessor :button_width, :button_height, :button_color, :button_font_size, :button_text_x, :button_text_y, :button_border_color
  
  def initialize
    self.button_width = 80
    self.button_height = 30
    self.button_font_size = 12
    self.button_color = :white
    self.button_border_color = {r: 201, g: 201, b: 201}
  end
  
  def rebuild_push_button
    @push_button.destroy
    @push_button_container.content { # re-open vertical box content and shove in a new button
      @push_button = push_button('Push',
                                 width: button_width, height: button_height,
                                 color: button_color, border_color: button_border_color,
                                 font_descriptor: {size: button_font_size}) {
        on_mouse_up do
          message_box('Button Pushed', 'Thank you for pushing the button')
        end
      }
    }
  end
  
  def launch
    window('Area-Based Custom Controls', 270, 270) {
      vertical_box {
        label('Push Button Construction Form') {
          stretchy false
        }
        form {
          color_button {
            label 'Color'
            color <=> [self, :button_color, after_write: method(:rebuild_push_button)]
          }
        }
        horizontal_box {
          label # filler to center button
          @push_button_container = vertical_box {
            @push_button = push_button('Push',
                                       width: button_width, height: button_height,
                                       color: button_color, border_color: button_border_color,
                                       font_descriptor: {size: button_font_size}) {
              on_mouse_up do
                message_box('Button Pushed', 'Thank you for pushing the button')
              end
            }
          }
          label # filler to center button
        }
      }
    }.show
  end
end

AreaBasedCustomControls.new.launch
