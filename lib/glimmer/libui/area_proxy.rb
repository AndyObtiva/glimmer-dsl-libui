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

using ArrayIncludeMethods

module Glimmer
  module LibUI
    # Proxy for LibUI area objects
    #
    # Follows the Proxy Design Pattern
    class AreaProxy < ControlProxy
      attr_reader :area_handler
    
      def post_initialize_child(child)
        super
        children << child
      end
      
      def children
        @children ||= []
      end
    
      private
      
      def build_control
        @area_handler = ::LibUI::FFI::AreaHandler.malloc
        @libui    = ::LibUI.new_area(@area_handler)
        @area_handler.Draw         = Fiddle::Closure::BlockCaller.new(0, [1, 1, 1]) do |_, _, area_draw_params|
          children.each {|child| child.draw(area_draw_params)}
        end
        @area_handler.MouseEvent   = Fiddle::Closure::BlockCaller.new(0, [0]) {}
        @area_handler.MouseCrossed = Fiddle::Closure::BlockCaller.new(0, [0]) {}
        @area_handler.DragBroken   = Fiddle::Closure::BlockCaller.new(0, [0]) {}
        @area_handler.KeyEvent     = Fiddle::Closure::BlockCaller.new(0, [0]) {}
      end
    end
  end
end
