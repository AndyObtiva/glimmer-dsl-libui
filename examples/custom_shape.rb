require 'glimmer-dsl-libui'

class CustomShape
  include Glimmer::LibUI::Application
  
  body {
    window {
      title 'Custom Shape'
      content_size 200, 225
    
      @area = area {
        rectangle(0, 0, 200, 225) {
          fill :white
        }
        
        7.times do |n|
          x_location = (rand*125).to_i%200 + (rand*15).to_i
          y_location = (rand*125).to_i%200 + (rand*15).to_i
          shape_color = [rand*125 + 130, rand*125 + 130, rand*125 + 130]
          shape_size = 20+n

          cube(location_x: x_location,
               location_y: y_location,
               rectangle_width: shape_size*2,
               rectangle_height: shape_size,
               cube_height: shape_size*2,
               background_color: shape_color,
               line_thickness: 2) {
            # TODO support listeners
            # TODO support extra properties
          }
        end
      }
    }
  }
  
  # method-based custom shape using `shape` keyword as a composite shape containing nested shapes
  # that are declared with relative positioning
  def cube(location_x: 0,
           location_y: 0,
           rectangle_width: nil,
           rectangle_height: nil,
           cube_height: nil,
           background_color: :brown,
           line_thickness: 1,
           &content_block)
    default_size = 28
    rectangle_width ||= rectangle_height || cube_height || default_size
    rectangle_height ||= rectangle_width || cube_height || default_size
    cube_height ||= rectangle_width || rectangle_height || default_size
    foreground_color = [0, 0, 0, thickness: line_thickness]
    
    shape(location_x, location_y) { |the_shape|
      polygon(0, cube_height + rectangle_height / 2.0,
              rectangle_width / 2.0, cube_height,
              rectangle_width, cube_height + rectangle_height / 2.0,
              rectangle_width / 2.0, cube_height + rectangle_height) {
        fill background_color
        stroke foreground_color
      }
      rectangle(0, rectangle_height / 2.0, rectangle_width, cube_height) {
        fill background_color
      }
      polyline(0, rectangle_height / 2.0 + cube_height,
               0, rectangle_height / 2.0,
               rectangle_width, rectangle_height / 2.0,
               rectangle_width, rectangle_height / 2.0 + cube_height) {
        stroke foreground_color
      }
      polygon(0, rectangle_height / 2.0,
              rectangle_width / 2.0, 0,
              rectangle_width, rectangle_height / 2.0,
              rectangle_width / 2.0, rectangle_height) {
        fill background_color
        stroke foreground_color
      }
      line(rectangle_width / 2.0, cube_height + rectangle_height,
           rectangle_width / 2.0, rectangle_height) {
        stroke foreground_color
      }
      
      content_block&.call(the_shape)
      
      # TODO do more with this
      on_mouse_up do |area_mouse_event|
        puts 'Mouse Up'
      end
    }
  end
end

CustomShape.launch
        
