require 'glimmer-dsl-libui'

# This is the method-based custom shape version of basic_custom_shape

class BasicCompositeShape
  include Glimmer::LibUI::Application
  
  body {
    window {
      title 'Basic Composite Shape'
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

          cube(
            location_x: x_location,
            location_y: y_location,
            rectangle_width: shape_size*2,
            rectangle_height: shape_size,
            cube_height: shape_size*2,
            background_color: shape_color,
            line_thickness: 2
          ) { |the_shape|
            on_mouse_up do |area_mouse_event|
              # Change color on mouse up without dragging
              if @drag_shape.nil?
                background_color = [rand(255), rand(255), rand(255)]
                the_shape.fill = background_color
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
        
        on_mouse_drop do |area_mouse_event|
          @drag_shape = nil
          @drag_x = nil
          @drag_y = nil
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
    
    # the shape keyword (alias for composite_shape) enables building a composite shape that is treated as one shape
    # like a cube containing polygons, a polyline, a rectangle, and a line
    # with the fill and stroke colors getting inherited by all children that do not specify them
    shape(location_x, location_y) { |the_shape|
      fill background_color
      stroke foreground_color
    
      bottom = polygon(0, cube_height + rectangle_height / 2.0,
              rectangle_width / 2.0, cube_height,
              rectangle_width, cube_height + rectangle_height / 2.0,
              rectangle_width / 2.0, cube_height + rectangle_height) {
        # inherits fill property from parent shape if not set
        # inherits stroke property from parent shape if not set
      }
      body = rectangle(0, rectangle_height / 2.0, rectangle_width, cube_height) {
        # inherits fill property from parent shape if not set
        # stroke is overridden to ensure a different value from parent
        stroke thickness: 0
      }
      polyline(0, rectangle_height / 2.0 + cube_height,
               0, rectangle_height / 2.0,
               rectangle_width, rectangle_height / 2.0,
               rectangle_width, rectangle_height / 2.0 + cube_height) {
        # inherits stroke property from parent shape if not set
      }
      top = polygon(0, rectangle_height / 2.0,
              rectangle_width / 2.0, 0,
              rectangle_width, rectangle_height / 2.0,
              rectangle_width / 2.0, rectangle_height) {
        # inherits fill property from parent shape if not set
        # inherits stroke property from parent shape if not set
      }
      line(rectangle_width / 2.0, cube_height + rectangle_height,
           rectangle_width / 2.0, rectangle_height) {
        # inherits stroke property from parent shape if not set
      }
      
      content_block&.call(the_shape)
    }
  end
end

BasicCompositeShape.launch
        
