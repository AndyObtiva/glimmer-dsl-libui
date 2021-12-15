# Copyright (c) 2021 Andy Maleh
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
            if end_x && end_y
              ::LibUI.draw_path_new_figure(path_proxy.libui, x, y)
              ::LibUI.draw_path_line_to(path_proxy.libui, end_x, end_y)
            else
              ::LibUI.draw_path_new_figure(path_proxy.libui, 0, 0)
              ::LibUI.draw_path_line_to(path_proxy.libui, x, y)
            end
          end
          super
        end
      end
    end
  end
end
