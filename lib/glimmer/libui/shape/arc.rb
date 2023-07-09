# Copyright (c) 2021-2023 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'glimmer/libui/shape'

module Glimmer
  module LibUI
    class Shape
      class Arc < Shape
        parameters :x_center, :y_center, :radius, :start_angle, :sweep, :is_negative
        parameter_defaults 0, 0, 0, 0, 360, false
                
        def draw(area_draw_params)
          arc_args = @args.dup
          arc_args[3] = Glimmer::LibUI.degrees_to_radians(arc_args[3])
          arc_args[4] = Glimmer::LibUI.degrees_to_radians(arc_args[4])
          arc_args[5] = Glimmer::LibUI.boolean_to_integer(arc_args[5], allow_nil: false)
          if parent.is_a?(Figure) && parent.x.nil? && parent.y.nil?
            ::LibUI.draw_path_new_figure_with_arc(path_proxy.libui, *arc_args)
          else
            if OS.windows? && parent.children.find {|child| child.is_a?(Arc)} == self
              ::LibUI.draw_path_new_figure_with_arc(path_proxy.libui, *arc_args)
            else
              ::LibUI.draw_path_arc_to(path_proxy.libui, *arc_args)
            end
          end
          super
        end
        
        def move_by(x_delta, y_delta)
          self.x_center += x_delta
          self.y_center += y_delta
        end
        
        def perfect_shape
          the_perfect_shape_dependencies = perfect_shape_dependencies
          if the_perfect_shape_dependencies != @perfect_shape_dependencies
            absolute_x_center, absolute_y_center, radius, start_angle, sweep, is_negative = @perfect_shape_dependencies = the_perfect_shape_dependencies
            sign = is_negative ? 1 : -1
            start = is_negative ? (360 - start_angle) : -1*start_angle
            extent = is_negative ? (360 - sweep) : -1*sweep
            @perfect_shape = PerfectShape::Arc.new(
              type: :open,
              center_x: absolute_x_center, center_y: absolute_y_center,
              radius_x: radius, radius_y: radius,
              start: start, extent: extent
            )
          end
          @perfect_shape
        end
        
        def perfect_shape_dependencies
          [absolute_x_center, absolute_y_center, radius, start_angle, sweep, is_negative]
        end
      end
    end
  end
end
