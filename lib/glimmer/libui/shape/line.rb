# Copyright (c) 2021-2022 Andy Maleh
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
      # Line to use as part of a figure (when having 2 args)
      # or independently (when having 4 args representing start point x/y and end point x/y)
      class Line < Shape
        parameters :x, :y, :end_x, :end_y
        parameter_defaults 0, 0, nil, nil
  
        def draw(area_draw_params)
          if parent.is_a?(Figure)
            ::LibUI.draw_path_line_to(path_proxy.libui, x, y)
          else
            if include_start_point?
              ::LibUI.draw_path_new_figure(path_proxy.libui, x, y)
              ::LibUI.draw_path_line_to(path_proxy.libui, end_x, end_y)
            else
              ::LibUI.draw_path_new_figure(path_proxy.libui, 0, 0)
              ::LibUI.draw_path_line_to(path_proxy.libui, x, y)
            end
          end
          super
        end
        
        # Indicates if line is not part of a figure and yet it includes the start point in addition to end point
        def include_start_point?
          # if the last 2 args are available, it means that the first 2 args represent the start point
          # if line is part of a figure, then the last 2 args are ignored and it is never assumed to include
          # start point
          !parent.is_a?(Figure) && end_x && end_y
        end
        
        def move_by(x_delta, y_delta)
          self.x += x_delta
          self.y += y_delta
          self.end_x += x_delta
          self.end_y += y_delta
        end
        
        def perfect_shape
          perfect_shape_dependencies = [x, y, end_x, end_y]
          if perfect_shape_dependencies != @perfect_shape_dependencies
            x, y, end_x, end_y = @perfect_shape_dependencies = perfect_shape_dependencies
            @perfect_shape = PerfectShape::Line.new(points: [x, y, end_x, end_y].compact)
          end
          @perfect_shape
        end
      end
    end
  end
end
