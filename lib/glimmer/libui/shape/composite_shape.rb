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
      class CompositeShape < Glimmer::LibUI::Shape
        # TODO support nested shape properties that apply to all children
        parameters :x, :y
        parameter_defaults 0, 0
      
        def draw(area_draw_params)
          children.each do |child|
            child_fill = child.fill
            child_stroke = child.stroke
            child_transform = child.transform
            child.fill = fill if Glimmer::LibUI.blank_color?(child.fill)
            child.stroke = stroke if Glimmer::LibUI.blank_color?(child.stroke)
            child.transform = transform if child.transform.nil?
            child.move_by(x, y)
            begin
              child.draw(area_draw_params)
            rescue Exception => e
              raise e
            ensure
              # restore original child attributes
              child.move_by(-x, -y)
              child.transform = child_transform
              child.stroke = Glimmer::LibUI.blank_color?(child_stroke) ? Glimmer::LibUI.blank_color : child_stroke
              child.fill = Glimmer::LibUI.blank_color?(child_fill) ? Glimmer::LibUI.blank_color : child_fill
            end
          end
          super
        end
        
        def transform(matrix = nil)
          if matrix.nil?
            @matrix
          else
            @matrix = matrix
          end
        end
        
        def move_by(x_delta, y_delta)
          self.x += x_delta
          self.y += y_delta
        end
        
        def contain?(*point, outline: false, distance_tolerance: 0)
          children.any? { |child| child.contain?(*point, outline: outline, distance_tolerance: distance_tolerance) }
        end
        
        def include?(*point)
          children.any? { |child| child.include?(*point) }
        end
        
        def relative_x(x)
          self.x + x
        end
        
        def relative_y(y)
          self.y + y
        end
        
        def relative_point(*point)
          [relative_x(point.first), relative_y(point.last)]
        end
        
        def perfect_shape
          perfect_shape_dependencies = [x, y, children.map(&:perfect_shape_dependencies)]
          if perfect_shape_dependencies != @perfect_shape_dependencies
            x, y, _ = @perfect_shape_dependencies = perfect_shape_dependencies
            shapes = children.map(&:perfect_shape)
            @perfect_shape = PerfectShape::CompositeShape.new(shapes: shapes)
          end
          @perfect_shape
        end
      end
    end
  end
end
