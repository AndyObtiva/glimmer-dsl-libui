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
      class Circle < Shape
        parameters :x_center, :y_center, :radius
        parameter_defaults 0, 0, 0
                
        def draw(area_draw_params)
          arc_args = @args.dup
          arc_args[3] = 0
          arc_args[4] = Math::PI * 2.0
          arc_args[5] = 0
          if parent.is_a?(Figure) && parent.x.nil? && parent.y.nil?
            ::LibUI.draw_path_new_figure_with_arc(path_proxy.libui, *arc_args)
          else
            if OS.windows? && parent.children.find {|child| child.is_a?(Circle)} == self
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
          perfect_shape_dependencies = [x_center, y_center, radius]
          if perfect_shape_dependencies != @perfect_shape_dependencies
            x_center, y_center, radius = @perfect_shape_dependencies = perfect_shape_dependencies
            @perfect_shape = PerfectShape::Circle.new(center_x: x_center, center_y: y_center, radius: radius)
          end
          @perfect_shape
        end
      end
    end
  end
end
