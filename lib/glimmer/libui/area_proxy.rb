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
require 'glimmer/fiddle_consumer'

module Glimmer
  module LibUI
    # Proxy for LibUI area objects
    #
    # Follows the Proxy Design Pattern
    class AreaProxy < ControlProxy
      include Glimmer::FiddleConsumer
      
      attr_reader :area_handler
      
      def post_initialize_child(child)
        super
        children << child
      end
      
      def post_add_content
        super
        install_listeners
      end
      
      def children
        @children ||= []
      end
      
      private
      
      def build_control
        @area_handler = ::LibUI::FFI::AreaHandler.malloc
        @libui    = ::LibUI.new_area(@area_handler)
      end
      
      def install_listeners
        @area_handler.Draw         = fiddle_closure_block_caller(0, [1, 1, 1]) do |_, _, area_draw_params|
          area_draw_params = ::LibUI::FFI::AreaDrawParams.new(area_draw_params)
          children.each {|child| child.draw(area_draw_params)}
        end
        @area_handler.MouseEvent   = fiddle_closure_block_caller(0, [0]) {}
        @area_handler.MouseCrossed = fiddle_closure_block_caller(0, [0]) {}
        @area_handler.DragBroken   = fiddle_closure_block_caller(0, [0]) {}
        @area_handler.KeyEvent     = fiddle_closure_block_caller(0, [0]) {}
      end
    end
  end
end
