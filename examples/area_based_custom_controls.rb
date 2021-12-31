require 'glimmer-dsl-libui'

include Glimmer

COLOR_GRAY = {r: 192, g: 192, b: 192}

def push_button(button_text, button_width: 50, button_height: 30, button_font: {}, bevel_percentage: 16, bevel_constant: 20, button_color: :white, &content)
  bevel_width_pixel_size = button_width.to_f * (bevel_percentage / 100.0)
  bevel_height_pixel_size = button_width.to_f * (bevel_percentage / 100.0)
  # gradient beginning: 72  146  247
  # gradient end: 12  85  214
  button_color = Glimmer::LibUI.interpret_color(button_color)
  button_parts = {}
  area { |a|
    button_parts[:background_rectangle] = rectangle(0, 0, button_width, button_height) {
      fill button_color
    }
    
    button_parts[:top_bevel_edge] = polygon {
      point_array 0, 0, button_width, 0, button_width - bevel_width_pixel_size, bevel_height_pixel_size, bevel_width_pixel_size, bevel_height_pixel_size
      fill r: button_color[:r] + 4*bevel_constant, g: button_color[:g] + 4*bevel_constant, b: button_color[:b] + 4*bevel_constant
    }
    
    button_parts[:right_bevel_edge] = polygon {
      point_array button_width, 0, button_width - bevel_width_pixel_size, bevel_height_pixel_size, button_width - bevel_width_pixel_size, button_height - bevel_height_pixel_size, button_width, button_height
      fill r: button_color[:r] - bevel_constant, g: button_color[:g] - bevel_constant, b: button_color[:b] - bevel_constant
    }
    
    button_parts[:bottom_bevel_edge] = polygon {
      point_array button_width, button_height, 0, button_height, bevel_width_pixel_size, button_height - bevel_height_pixel_size, button_width - bevel_width_pixel_size, button_height - bevel_height_pixel_size
      fill r: button_color[:r] - bevel_constant, g: button_color[:g] - bevel_constant, b: button_color[:b] - bevel_constant
    }
    
    button_parts[:left_bevel_edge] = polygon {
      point_array 0, 0, 0, button_height, bevel_width_pixel_size, button_height - bevel_height_pixel_size, bevel_width_pixel_size, bevel_height_pixel_size
      fill r: button_color[:r] - bevel_constant, g: button_color[:g] - bevel_constant, b: button_color[:b] - bevel_constant
    }
    
    button_parts[:border_rectangle] = rectangle(0, 0, button_width, button_height) {
      stroke COLOR_GRAY
    }
    
    text_font_size = (button_font[:size] || 12)
    text_width = text_font_size * button_text.size
    text(button_width / 2.0 - text_width, button_height / 2.0 - text_font_size, text_width) {
      button_parts[:button_string] = string(button_text) {
        font button_font
      }
    }
    
    on_mouse_down do
      button_parts[:background_rectangle].fill = {x0: 0, y0: 0, x1: 0, y1: button_height, stops: [{pos: 0, r: 72, g: 146, b: 247}, {pos: 1, r: 12, g: 85, b: 214}]}
      button_parts[:button_string].color = :white
    end
    
    on_mouse_up do
      button_parts[:background_rectangle].fill = button_color
      button_parts[:button_string].color = :black
    end
    
    content.call(a)
  }
end

window('Area-Based Custom Controls', 320, 240) {
  vertical_box {
    push_button('Push', button_color: :lightgray, button_width: 300, button_height: 200, button_font: {size: 30}, bevel_percentage: 4) {
      on_mouse_up do
        message_box('Button Pushed', 'Thank you for pushing the button')
      end
    }
    
    button('Push') {
      stretchy false
      
      on_clicked do
        message_box('Button Pushed', 'Thank you for pushing the button')
      end
    }
    
  }
}.show
