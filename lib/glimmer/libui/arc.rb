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
    class Arc < Shape
      parameters :x_center, :y_center, :radius, :start_angle, :sweep, :is_negative
              
      def draw(area_draw_params)
        @args[5] = ControlProxy.boolean_to_integer(@args[5], allow_nil: false)
        if parent.is_a?(Figure) && parent.x.nil? && parent.y.nil?
          ::LibUI.draw_path_new_figure_with_arc(path_proxy.libui, *@args)
        else
          ::LibUI.draw_path_arc_to(path_proxy.libui, *@args)
        end
        super
      end
    end
  end
end
