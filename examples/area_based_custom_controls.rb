require 'glimmer-dsl-libui'

include Glimmer

# Graphical push button built with vector graphics on top of area
# text_x and text_y are the offset of the button text in releation to its top-left corner
# When text_x, text_y are left nil, the text is automatically centered in the button area.
# Sometimes, the centering calculation is not perfect due to using a custom font, so
# in that case, pass in text_x, and text_y manually
def push_button(button_text,
                width: 80, height: 30, font_descriptor: {},
                background_color: :white, text_color: :black, border_color: {r: 201, g: 201, b: 201},
                text_x: nil, text_y: nil,
                &content)
  background_color = Glimmer::LibUI.interpret_color(background_color) # gets a color rgb hash
  button_parts = {}
  area { |a|
    button_parts[:background_rectangle] = rectangle(1, 1, width, height) {
      fill background_color
    }
    
    button_parts[:border_rectangle] = rectangle(1, 1, width, height) {
      stroke border_color
    }
    
    text_height = (font_descriptor[:size] || 12) * 0.75
    text_width = (text_height * button_text.size) * 0.75
    text_x = nil if text_x == 0
    text_y = nil if text_y == 0
    text_x ||= (width - text_width) / 2.0
    text_y ||= (height - 4 - text_height) / 2.0
    text(text_x, text_y, width) {
      button_parts[:button_string] = string(button_text) {
        color text_color
        font font_descriptor
      }
    }
    
    on_mouse_down do
      button_parts[:background_rectangle].fill = {x0: 0, y0: 0, x1: 0, y1: height, stops: [{pos: 0, r: 72, g: 146, b: 247}, {pos: 1, r: 12, g: 85, b: 214}]}
      button_parts[:button_string].color = :white
    end
    
    on_mouse_up do
      button_parts[:background_rectangle].fill = background_color
      button_parts[:button_string].color = text_color
    end
    
    content.call(a)
  }
end

class AreaBasedCustomControls
  include Glimmer
  
  attr_accessor :button_width, :button_height, :button_font_size,
                :button_text_color, :button_background_color, :button_border_color,
                :button_text_x, :button_text_y
  
  def initialize
    self.button_width = 80
    self.button_height = 30
    self.button_font_size = 12
    self.button_background_color = :white
    self.button_text_color = :black
    self.button_border_color = {r: 201, g: 201, b: 201}
    self.button_text_x = 0 # auto-calculated
    self.button_text_y = 0 # auto-calculated
  end
  
  def rebuild_push_button
    @push_button.destroy
    @window_vertical_box.content { # re-open vertical box content and shove in a new button
      @push_button = push_button('Push',
                                 width: button_width, height: button_height, font_descriptor: {size: button_font_size},
                                 background_color: button_background_color, text_color: button_text_color, border_color: button_border_color,
                                 text_x: button_text_x, text_y: button_text_y) {
        on_mouse_up do
          message_box('Button Pushed', 'Thank you for pushing the button')
        end
      }
    }
  end
  
  def launch
    window('Area-Based Custom Controls', 270, 270) {
      margined true
      
      @window_vertical_box = vertical_box {
        label('Push Button Construction Form:') {
          stretchy false
        }
        form {
          spinbox(1, 1000) {
            label 'Width'
            value <=> [self, :button_width, after_write: method(:rebuild_push_button)]
          }
          spinbox(1, 1000) {
            label 'Height'
            value <=> [self, :button_height, after_write: method(:rebuild_push_button)]
          }
          spinbox(1, 72) {
            label 'Font Size'
            value <=> [self, :button_font_size, after_write: method(:rebuild_push_button)]
          }
          color_button {
            label 'Text Color'
            color <=> [self, :button_text_color, after_write: method(:rebuild_push_button)]
          }
          color_button {
            label 'Background Color'
            color <=> [self, :button_background_color, after_write: method(:rebuild_push_button)]
          }
          color_button {
            label 'Border Color'
            color <=> [self, :button_border_color, after_write: method(:rebuild_push_button)]
          }
          spinbox(0, 1000) {
            label 'Text X (0=centered)'
            value <=> [self, :button_text_x, after_write: method(:rebuild_push_button)]
          }
          spinbox(0, 1000) {
            label 'Text Y (0=centered)'
            value <=> [self, :button_text_y, after_write: method(:rebuild_push_button)]
          }
        }
          
        @push_button = push_button('Push',
                                   width: button_width, height: button_height, font_descriptor: {size: button_font_size},
                                   background_color: button_background_color, text_color: button_text_color, border_color: button_border_color,
                                   text_x: button_text_x, text_y: button_text_y) {
          on_mouse_up do
            message_box('Button Pushed', 'Thank you for pushing the button')
          end
        }
      }
    }.show
  end
end

AreaBasedCustomControls.new.launch
