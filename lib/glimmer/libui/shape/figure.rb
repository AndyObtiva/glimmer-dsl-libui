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
      # Represents a figure consisting of shapes (nested under path)
      # Can optionally have `closed true` property (connecting last point to first point automatically)
      class Figure < Shape
        parameters :x, :y
        parameter_defaults nil, nil
      
        def draw(area_draw_params)
          ::LibUI.draw_path_new_figure(path_proxy.libui, *@args) unless @args.compact.empty? # TODO if args empty then wait till there is an arc child and it starts the figure
          children.dup.each {|child| child.draw(area_draw_params)}
          ::LibUI.draw_path_close_figure(path_proxy.libui) if closed?
          super
        end
        
        def closed(value = nil)
          if value.nil?
            @closed
          else
            if !!value != !!@closed
              @closed = value
              request_auto_redraw
            end
          end
        end
        alias closed= closed
        alias set_closed closed
        alias closed? closed
        
        def perfect_shape
          perfect_shape_dependencies = [x, y, closed, parent.draw_fill_mode, children]
          if perfect_shape_dependencies != @perfect_shape_dependencies
            x, y, closed, draw_fill_mode, children = @perfect_shape_dependencies = perfect_shape_dependencies
            path_shapes = [[x, y]]
            path_shapes += children.map(&:perfect_shape)
            winding_rule = draw_fill_mode == :winding ? :wind_non_zero : :wind_even_odd
            @perfect_shape = PerfectShape::Path.new(closed: closed, winding_rule: winding_rule, shapes: path_shapes)
          end
          @perfect_shape
        end
      end
    end
  end
end
