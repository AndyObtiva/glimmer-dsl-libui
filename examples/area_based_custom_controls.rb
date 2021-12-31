require 'glimmer-dsl-libui'

class AreaBasedCustomControls
  include Glimmer
  
  attr_accessor :button_width, :button_height, :button_font_descriptor,
                :button_text_color, :button_background_fill, :button_border_stroke,
                :button_text_x, :button_text_y,
                :label_width, :label_height, :label_font_descriptor,
                :label_text_color, :label_background_fill, :label_border_stroke,
                :label_text_x, :label_text_y
  
  def initialize
    self.label_width = 250
    self.label_height = 50
    self.label_font_descriptor = {family: OS.linux? ? 'Bitstream Vera Sans Mono' : 'Courier New', size: 16, weight: :bold, italic: :italic}
    self.label_text_color = :red
    self.label_background_fill = :yellow
    self.label_border_stroke = :limegreen
    
    self.button_width = 130
    self.button_height = 50
    self.button_font_descriptor = {family: OS.linux? ? 'Bitstream Vera Sans Mono' : 'Courier New', size: 36, weight: :bold, italic: :italic}
    self.button_text_color = :green
    self.button_background_fill = :yellow
    self.button_border_stroke = :limegreen
  end
  
  def rebuild_text_label
    @text_label.destroy
    @text_label_vertical_box.content { # re-open vertical box content and shove in a new button
      @text_label = text_label('This is a text label.',
                               width: label_width, height: label_height, font_descriptor: label_font_descriptor,
                               background_fill: label_background_fill, text_color: label_text_color, border_stroke: label_border_stroke,
                               text_x: label_text_x, text_y: label_text_y)
    }
  end
  
  def rebuild_push_button
    @push_button.destroy
    @push_button_vertical_box.content { # re-open vertical box content and shove in a new button
      @push_button = push_button('Push',
                                 width: button_width, height: button_height, font_descriptor: button_font_descriptor,
                                 background_fill: button_background_fill, text_color: button_text_color, border_stroke: button_border_stroke,
                                 text_x: button_text_x, text_y: button_text_y) {
        on_mouse_up do
          message_box('Button Pushed', 'Thank you for pushing the button!')
        end
      }
    }
  end
  
  def launch
    window('Area-Based Custom Controls', 270, 350) { |w|
      margined true
      
      tab {
        tab_item('Text Label') {
          @text_label_vertical_box = vertical_box {
            vertical_box {
              text_label('Text Label Construction Form:', width: 250, height: 30, font_descriptor: {size: 16, weight: :bold}, text_x: 0, text_y: 0)
              
              horizontal_box {
                label('Width')
                spinbox(1, 1000) {
                  value <=> [self, :label_width, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Height')
                spinbox(1, 1000) {
                  value <=> [self, :label_height, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Font')
                font_button {
                  font <=> [self, :label_font_descriptor, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Text Color')
                color_button {
                  color <=> [self, :label_text_color, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Background Color')
                color_button {
                  color <=> [self, :label_background_fill, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Border Color')
                color_button {
                  color <=> [self, :label_border_stroke, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Text X (0=centered)')
                spinbox(0, 1000) {
                  value <=> [self, :label_text_x, on_read: ->(x) {x.nil? ? 0 : x}, on_write: ->(x) {x == 0 ? nil : x}, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Text Y (0=centered)')
                spinbox(0, 1000) {
                  value <=> [self, :label_text_y, on_read: ->(y) {y.nil? ? 0 : y}, on_write: ->(y) {y == 0 ? nil : y}, after_write: method(:rebuild_text_label)]
                }
              }
            }
            
            @text_label = text_label('This is a text label.',
                                     width: label_width, height: label_height, font_descriptor: label_font_descriptor,
                                     background_fill: label_background_fill, text_color: label_text_color, border_stroke: label_border_stroke,
                                     text_x: label_text_x, text_y: label_text_y)
          }
        }
        
        tab_item('Push Button') {
          @push_button_vertical_box = vertical_box {
            vertical_box {
              text_label('Push Button Construction Form:', width: 250, height: 30, font_descriptor: {size: 16, weight: :bold}, text_x: 0, text_y: 0)
              
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
                label('Font')
                font_button {
                  font <=> [self, :button_font_descriptor, after_write: method(:rebuild_push_button)]
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
                  color <=> [self, :button_background_fill, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Border Color')
                color_button {
                  color <=> [self, :button_border_stroke, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Text X (0=centered)')
                spinbox(0, 1000) {
                  value <=> [self, :button_text_x, on_read: ->(x) {x.nil? ? 0 : x}, on_write: ->(x) {x == 0 ? nil : x}, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Text Y (0=centered)')
                spinbox(0, 1000) {
                  value <=> [self, :button_text_y, on_read: ->(y) {y.nil? ? 0 : y}, on_write: ->(y) {y == 0 ? nil : y}, after_write: method(:rebuild_push_button)]
                }
              }
            }
            
            @push_button = push_button('Push',
                                       width: button_width, height: button_height, font_descriptor: button_font_descriptor,
                                       background_fill: button_background_fill, text_color: button_text_color, border_stroke: button_border_stroke,
                                       text_x: button_text_x, text_y: button_text_y) {
              on_mouse_up do
                message_box('Button Pushed', 'Thank you for pushing the button!')
              end
            }
          }
        }
      }
    }.show
  end
    
  # text label (area-based custom control) built with vector graphics on top of area.
  #
  # background_fill is transparent by default.
  # background_fill can accept a single color or gradient stops just as per `fill` property in README.
  # border_stroke is transparent by default.
  # border_stroke can accept thickness and dashes in addition to color just as per `stroke` property in README.
  def text_label(label_text,
                  width: 80, height: 30, font_descriptor: {},
                  background_fill: {a: 0}, text_color: :black, border_stroke: {a: 0},
                  text_x: nil, text_y: nil,
                  &content)
    area { |the_area|
      rectangle(1, 1, width, height) {
        fill background_fill
      }
      rectangle(1, 1, width, height) {
        stroke border_stroke
      }
      
      text_height = (font_descriptor[:size] || 12) * 0.75
      text_width = (text_height * label_text.size) * 0.75
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
  
  # push button (area-based custom control) built with vector graphics on top of area.
  #
  # background_fill is white by default.
  # background_fill can accept a single color or gradient stops just as per `fill` property in README.
  # border_stroke is black by default.
  # border_stroke can accept thickness and dashes in addition to color just as per `stroke` property in README.
  # text_x and text_y are the offset of the button text in releation to its top-left corner
  # When text_x, text_y are left nil, the text is automatically centered in the button area.
  # Sometimes, the centering calculation is not perfect due to using a custom font, so
  # in that case, pass in text_x, and text_y manually
  #
  # reuses the text_label custom control
  def push_button(button_text,
                  width: 80, height: 30, font_descriptor: {},
                  background_fill: :white, text_color: :black, border_stroke: {r: 201, g: 201, b: 201},
                  text_x: nil, text_y: nil,
                  &content)
    text_label(button_text,
                  width: width, height: height, font_descriptor: font_descriptor,
                  background_fill: background_fill, text_color: text_color, border_stroke: border_stroke,
                  text_x: text_x, text_y: text_y) { |the_area|
      
      # dig into the_area content and grab elements to modify in mouse listeners below
      background_rectangle = the_area.children[0]
      button_string = the_area.children[2].children[0]
      
      on_mouse_down do
        background_rectangle.fill = {x0: 0, y0: 0, x1: 0, y1: height, stops: [{pos: 0, r: 72, g: 146, b: 247}, {pos: 1, r: 12, g: 85, b: 214}]}
        button_string.color = :white
      end
      
      on_mouse_up do
        background_rectangle.fill = background_fill
        button_string.color = text_color
      end
      
      content&.call(the_area)
    }
  end
end

AreaBasedCustomControls.new.launch
