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
      class Polygon < Shape
        parameters :point_array
        parameter_defaults []
      
        def draw(area_draw_params)
          alternating_x_y_array = point_array.to_a.compact.flatten
          unless alternating_x_y_array.empty?
            ::LibUI.draw_path_new_figure(path_proxy.libui, alternating_x_y_array[0], alternating_x_y_array[1])
            ((alternating_x_y_array.size - 2) / 2).times do |n|
              point_alternating_x_y_index = n * 2
              ::LibUI.draw_path_line_to(path_proxy.libui, alternating_x_y_array[point_alternating_x_y_index + 2], alternating_x_y_array[point_alternating_x_y_index + 3])
            end
            ::LibUI.draw_path_close_figure(path_proxy.libui)
          end
          super
        end
        
        def move_by(x_delta, y_delta)
          self.point_array = point_array.each_with_index.map {|coordinate, i| i.even? ? coordinate + x_delta : coordinate + y_delta}
        end
        
        def perfect_shape
          require 'perfect-shape'
          the_perfect_shape_dependencies = perfect_shape_dependencies
          if the_perfect_shape_dependencies != @perfect_shape_dependencies
            absolute_point_array = @perfect_shape_dependencies = the_perfect_shape_dependencies
            path_shapes = [absolute_point_array.first]
            path_shapes += absolute_point_array.drop(1).map { |point| PerfectShape::Line.new(points: [point]) }
            @perfect_shape = PerfectShape::Path.new(closed: true, shapes: path_shapes)
          end
          @perfect_shape
        end
        
        def perfect_shape_dependencies
          absolute_point_array
        end
      end
    end
  end
end
