# Copyright (c) 2021-2024 Andy Maleh
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
      class Rectangle < Shape
        parameters :x, :y, :width, :height
        parameter_defaults 0, 0, 0, 0
      
        def draw(area_draw_params)
          ::LibUI.draw_path_add_rectangle(path_proxy.libui, *@args)
          super
        end
        
        def move_by(x_delta, y_delta)
          self.x += x_delta
          self.y += y_delta
        end
        
        def perfect_shape
          require 'perfect-shape'
          the_perfect_shape_dependencies = perfect_shape_dependencies
          if the_perfect_shape_dependencies != @perfect_shape_dependencies
            absolute_x, absolute_y, width, height = @perfect_shape_dependencies = the_perfect_shape_dependencies
            @perfect_shape = PerfectShape::Rectangle.new(x: absolute_x, y: absolute_y, width: width, height: height)
          end
          @perfect_shape
        end
        
        def perfect_shape_dependencies
          [absolute_x, absolute_y, width, height]
        end
      end
    end
  end
end
