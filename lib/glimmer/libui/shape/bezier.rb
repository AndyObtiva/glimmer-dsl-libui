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
      class Bezier < Shape
        parameters :x, :y, :c1_x, :c1_y, :c2_x, :c2_y, :end_x, :end_y
        parameter_defaults nil, nil, 0, 0, 0, 0, 0, 0
                
        def initialize(keyword, parent, args, &block)
          args.prepend nil until args.size == 8
          super(keyword, parent, args, &block)
        end
                
        def draw(area_draw_params)
          if !parent.is_a?(Figure)
            if include_start_point?
              ::LibUI.draw_path_new_figure(path_proxy.libui, x, y)
            else
              ::LibUI.draw_path_new_figure(path_proxy.libui, 0, 0)
            end
          end
          ::LibUI.draw_path_bezier_to(path_proxy.libui, c1_x, c1_y, c2_x, c2_y, end_x, end_y)
          super
        end
        
        # Indicates if bezier is not part of a figure and yet it includes the start point in addition to other points
        def include_start_point?
          x && y
        end
        
        def move_by(x_delta, y_delta)
          self.x += x_delta
          self.y += y_delta
          self.c1_x += x_delta
          self.c1_y += y_delta
          self.c2_x += x_delta
          self.c2_y += y_delta
          self.end_x += x_delta
          self.end_y += y_delta
        end
        
        def perfect_shape
          the_perfect_shape_dependencies = perfect_shape_dependencies
          if the_perfect_shape_dependencies != @perfect_shape_dependencies
            absolute_x, absolute_y, absolute_c1_x, absolute_c1_y, absolute_c2_x, absolute_c2_y, absolute_end_x, absolute_end_y = @perfect_shape_dependencies = the_perfect_shape_dependencies
            @perfect_shape = PerfectShape::CubicBezierCurve.new(points: [absolute_x, absolute_y, absolute_c1_x, absolute_c1_y, absolute_c2_x, absolute_c2_y, absolute_end_x, absolute_end_y].compact)
          end
          @perfect_shape
        end
        
        def perfect_shape_dependencies
          [absolute_x, absolute_y, absolute_c1_x, absolute_c1_y, absolute_c2_x, absolute_c2_y, absolute_end_x, absolute_end_y]
        end
      end
    end
  end
end
