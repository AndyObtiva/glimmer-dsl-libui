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

require 'glimmer/libui/control_proxy'

module Glimmer
  module LibUI
    # Proxy for LibUI rectangle objects
    #
    # Follows the Proxy Design Pattern
    class RectangleProxy < ControlProxy
      def initialize(keyword, parent, args, &block)
        @keyword = keyword
        @parent_proxy = parent
        @args = args
        @block = block
        @enabled = true
        post_add_content if @block.nil?
      end
    
      def draw(area_draw_params)
        ::LibUI.draw_path_add_rectangle(@parent_proxy.libui, *@args)
        destroy if @parent_proxy.parent_proxy.nil?
      end
      
      def destroy
        @parent_proxy.children.delete(self) unless @parent_proxy.nil?
        ControlProxy.control_proxies.delete(self)
      end
      
      def x(value = nil)
        if value.nil?
          @args[0]
        else
          @args[0] = value
          @parent_proxy.parent_proxy&.queue_redraw_all
        end
      end
      alias x= x
      alias set_x x
      
      def y(value = nil)
        if value.nil?
          @args[1]
        else
          @args[1] = value
          @parent_proxy.parent_proxy&.queue_redraw_all
        end
      end
      alias y= y
      alias set_y y
      
      def width(value = nil)
        if value.nil?
          @args[2]
        else
          @args[2] = value
          @parent_proxy.parent_proxy&.queue_redraw_all
        end
      end
      alias width= width
      alias set_width width
      
      def height(value = nil)
        if value.nil?
          @args[3]
        else
          @args[3] = value
          @parent_proxy.parent_proxy&.queue_redraw_all
        end
      end
      alias height= height
      alias set_height height
      
      private
      
      def build_control
        # No Op
      end
    end
  end
end
