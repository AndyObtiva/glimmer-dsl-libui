require 'glimmer-dsl-libui'

include Glimmer

# text label (area-based custom control) built with vector graphics on top of area
def text_label(label_text,
                width: 80, height: 30, font_descriptor: {},
                background_color: {r: 236, g: 236, b: 236}, text_color: :black, border_color: {r: 236, g: 236, b: 236},
                text_x: nil, text_y: nil,
                &content)
  background_color = Glimmer::LibUI.interpret_color(background_color) # gets a color rgb hash
  area { |the_area|
    rectangle(1, 1, width, height) {
      fill background_color
    }
    rectangle(1, 1, width, height) {
      stroke border_color
    }
    
    text_height = (font_descriptor[:size] || 12) * 0.75
    text_width = (text_height * label_text.size) * 0.75
    text_x = nil if text_x == 0
    text_y = nil if text_y == 0
    text_x ||= (width - text_width) / 2.0
    text_y ||= (height - 4 - text_height) / 2.0
    text(text_x, text_y, width) {
      string(label_text) {
        color text_color
        font font_descriptor
      }
    }
    
    content&.call(the_area)
  }
end

# push button (area-based custom control) built with vector graphics on top of area
# text_x and text_y are the offset of the button text in releation to its top-left corner
# When text_x, text_y are left nil, the text is automatically centered in the button area.
# Sometimes, the centering calculation is not perfect due to using a custom font, so
# in that case, pass in text_x, and text_y manually
#
# reuses the text_label custom control
def push_button(button_text,
                width: 80, height: 30, font_descriptor: {},
                background_color: :white, text_color: :black, border_color: {r: 201, g: 201, b: 201},
                text_x: nil, text_y: nil,
                &content)
  text_label(button_text,
                width: width, height: height, font_descriptor: font_descriptor,
                background_color: background_color, text_color: text_color, border_color: border_color,
                text_x: text_x, text_y: text_y) { |the_area|
    
    # dig into the_area content and grab elements to modify in mouse listeners below
    background_rectangle = the_area.children[0]
    button_string = the_area.children[2].children[0]
    
    on_mouse_down do
      background_rectangle.fill = {x0: 0, y0: 0, x1: 0, y1: height, stops: [{pos: 0, r: 72, g: 146, b: 247}, {pos: 1, r: 12, g: 85, b: 214}]}
      button_string.color = :white
    end
    
    on_mouse_up do
      background_rectangle.fill = background_color
      button_string.color = text_color
    end
    
    content&.call(the_area)
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
    window('Area-Based Custom Controls', 270, 350) { |w|
      margined true
      
      @window_vertical_box = vertical_box {
        vertical_box {
          text_label('Push Button Construction Form:', width: 250, height: 30, font_descriptor: {size: 16, weight: :bold}, text_x: 1, text_y: 1)
          
          horizontal_box {
            label('Width')
            spinbox(1, 1000) {
              value <=> [self, :button_width, after_write: method(:rebuild_push_button)]
            }
          }
          
          horizontal_box {
            label('Height')
            spinbox(1, 1000) {
              value <=> [self, :button_height, after_write: method(:rebuild_push_button)]
            }
          }
          
          horizontal_box {
            label('Font Size')
            spinbox(1, 72) {
              value <=> [self, :button_font_size, after_write: method(:rebuild_push_button)]
            }
          }
          
          horizontal_box {
            label('Text Color')
            color_button {
              color <=> [self, :button_text_color, after_write: method(:rebuild_push_button)]
            }
          }
          
          horizontal_box {
            label('Background Color')
            color_button {
              color <=> [self, :button_background_color, after_write: method(:rebuild_push_button)]
            }
          }
          
          horizontal_box {
            label('Border Color')
            color_button {
              color <=> [self, :button_border_color, after_write: method(:rebuild_push_button)]
            }
          }
          
          horizontal_box {
            label('Text X (0=centered)')
            spinbox(0, 1000) {
              value <=> [self, :button_text_x, after_write: method(:rebuild_push_button)]
            }
          }
          
          horizontal_box {
            label('Text Y (0=centered)')
            spinbox(0, 1000) {
              value <=> [self, :button_text_y, after_write: method(:rebuild_push_button)]
            }
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
