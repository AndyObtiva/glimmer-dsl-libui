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
    # Represents a figure consisting of shapes (nested under path)
    # Can optionally have `closed true` property (connecting last point to first point automatically)
    class Figure < Shape
      parameters :x, :y
    
      def draw(area_draw_params)
        ::LibUI.draw_path_new_figure(path_proxy.libui, *@args) unless @args.empty? # TODO if args empty then wait till there is an arc child and it starts the figure
        children.each {|child| child.draw(area_draw_params)}
        ::LibUI.draw_path_close_figure(path_proxy.libui) if closed?
        super
      end
      
      def closed(value = nil)
        if value.nil?
          @closed
        else
          @closed = value
          area_proxy&.queue_redraw_all
        end
      end
      alias closed= closed
      alias set_closed closed
      alias closed? closed
    end
  end
end
