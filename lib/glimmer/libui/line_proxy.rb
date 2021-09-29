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
    # Proxy for LibUI line objects
    #
    # Follows the Proxy Design Pattern
    class LineProxy < ControlProxy
      def initialize(keyword, parent, args, &block)
        @keyword = keyword
        @parent_proxy = parent
        @args = args
        @block = block
        @enabled = true
        post_add_content if @block.nil?
      end
    
      def draw(area_draw_params)
        ::LibUI.draw_path_line_to(path_proxy.libui, *@args)
        destroy if area_proxy.nil?
      end
      
      def destroy
        @parent_proxy.children.delete(self) unless @parent_proxy.nil?
        ControlProxy.control_proxies.delete(self)
      end
      
      def area_proxy
        found_proxy = self
        until found_proxy.nil? || found_proxy.is_a?(AreaProxy)
          found_proxy = found_proxy.parent_proxy
        end
        found_proxy
      end
      
      def path_proxy
        found_proxy = self
        until found_proxy.nil? || found_proxy.is_a?(PathProxy)
          found_proxy = found_proxy.parent_proxy
        end
        found_proxy
      end
      
      def x(value = nil)
        if value.nil?
          @args[0]
        else
          @args[0] = value
          area_proxy&.queue_redraw_all
        end
      end
      alias x= x
      alias set_x x
      
      def y(value = nil)
        if value.nil?
          @args[1]
        else
          @args[1] = value
          area_proxy&.queue_redraw_all
        end
      end
      alias y= y
      alias set_y y
      
      private
      
      def build_control
        # No Op
      end
    end
  end
end
