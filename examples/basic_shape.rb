require 'glimmer-dsl-libui'

class BasicShape
  include Glimmer::LibUI::Application
  
  body {
    window {
      title 'Basic Shape'
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
        
        # this general area on_mouse_drag listener is needed to ensure that dragging a shape
        # outside of its boundaries would still move the dragged shape
        on_mouse_drag do |area_mouse_event|
          if @drag_shape && @drag_x && @drag_y
            drag_distance_width = area_mouse_event[:x]  - @drag_x
            drag_distance_height = area_mouse_event[:y] - @drag_y
            @drag_shape.x += drag_distance_width
            @drag_shape.y += drag_distance_height
            @drag_x = area_mouse_event[:x]
            @drag_y = area_mouse_event[:y]
          end
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
      bottom = polygon(0, cube_height + rectangle_height / 2.0,
              rectangle_width / 2.0, cube_height,
              rectangle_width, cube_height + rectangle_height / 2.0,
              rectangle_width / 2.0, cube_height + rectangle_height) {
        fill background_color
        stroke foreground_color
      }
      body = rectangle(0, rectangle_height / 2.0, rectangle_width, cube_height) {
        fill background_color
      }
      polyline(0, rectangle_height / 2.0 + cube_height,
               0, rectangle_height / 2.0,
               rectangle_width, rectangle_height / 2.0,
               rectangle_width, rectangle_height / 2.0 + cube_height) {
        stroke foreground_color
      }
      top = polygon(0, rectangle_height / 2.0,
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
      
      on_mouse_up do |area_mouse_event|
        if @drag_shape.nil? # while not dragging
          background_color = [rand(255), rand(255), rand(255)]
          top.fill = background_color
          body.fill = background_color
          bottom.fill = background_color
          the_shape.redraw
        end
      end
      
      on_mouse_drag_start do |area_mouse_event|
        @drag_shape = the_shape
        @drag_x = area_mouse_event[:x]
        @drag_y = area_mouse_event[:y]
      end
      
      on_mouse_drag do |area_mouse_event|
        if @drag_shape && @drag_x && @drag_y
          drag_distance_width = area_mouse_event[:x]  - @drag_x
          drag_distance_height = area_mouse_event[:y] - @drag_y
          @drag_shape.x += drag_distance_width
          @drag_shape.y += drag_distance_height
          @drag_x = area_mouse_event[:x]
          @drag_y = area_mouse_event[:y]
        end
      end
      
      on_mouse_drop do |area_mouse_event|
        @drag_shape = nil
        @drag_x = nil
        @drag_y = nil
      end
    }
  end
end

BasicShape.launch
        
