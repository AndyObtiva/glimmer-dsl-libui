require 'glimmer-dsl-libui'

# This is the class-based custom shape version of basic_composite_shape

# class-based custom shape using Glimmer::LibUI::CustomShape mixin, which automatically
# augments the Glimmer GUI DSL with the underscored version of the class name: `cube`
# while accepting hash options matching the options declared on the class.
# (e.g. `cube(location_x: 50, location_y: 100)` )
class Cube
  include Glimmer::LibUI::CustomShape
  
  DEFAULT_SIZE = 28
  
  option :location_x, default: 0
  option :location_y, default: 0
  option :rectangle_width, default: nil
  option :rectangle_height, default: nil
  option :cube_height, default: 75
  option :background_color, default: :brown
  option :foreground_color
  option :line_thickness, default: 1
    
  # The before_body block executes before building the body
  before_body do
    self.rectangle_width ||= rectangle_height || cube_height || DEFAULT_SIZE
    self.rectangle_height ||= rectangle_width || cube_height || DEFAULT_SIZE
    self.cube_height ||= rectangle_width || rectangle_height || DEFAULT_SIZE
    if foreground_color
      self.foreground_color = Glimmer::LibUI.interpret_color(foreground_color)
      self.foreground_color[:thickness] ||= line_thickness
    else
      self.foreground_color = [0, 0, 0, thickness: line_thickness]
    end
  end
  
  # Optionally, after_body could be defined to perform operations after building the body
  # like setting up observers.
  #
  # after_body do
  # end
  
  body {
    # the shape keyword (alias for composite_shape) enables building a composite shape that is treated as one shape
    # like a cube containing polygons, a polyline, a rectangle, and a line
    # with the fill and stroke colors getting inherited by all children that do not specify them
    shape(location_x, location_y) {
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
    }
  }
end

class BasicCustomShape
  include Glimmer::LibUI::Application
  
  body {
    window {
      title 'Basic Custom Shape'
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
end

BasicCustomShape.launch
        
