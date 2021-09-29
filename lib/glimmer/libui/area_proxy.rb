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
      
      def on_draw(&block)
        @on_draw_procs ||= []
        if block.nil?
          @on_draw_procs
        else
          @on_draw_procs << block
          block
        end
      end
      
      def can_handle_listener?(listener_name)
        listener_name == 'on_draw' || super
      end
      
      def handle_listener(listener_name, &listener)
        case listener_name
        when 'on_draw'
          on_draw(&listener)
        else
          super
        end
      end
      
      private
      
      def build_control
        @area_handler = ::LibUI::FFI::AreaHandler.malloc
        @libui    = ::LibUI.new_area(@area_handler)
      end
      
      def install_listeners
        @area_handler.Draw         = fiddle_closure_block_caller(0, [1, 1, 1]) do |_, _, area_draw_params|
          area_draw_params = ::LibUI::FFI::AreaDrawParams.new(area_draw_params)
          area_draw_params = area_draw_params_hash(area_draw_params)
          children.dup.each {|child| child.draw(area_draw_params)}
          on_draw.each {|listener| listener.call(area_draw_params) }
        end
        @area_handler.MouseEvent   = fiddle_closure_block_caller(0, [0]) {}
        @area_handler.MouseCrossed = fiddle_closure_block_caller(0, [0]) {}
        @area_handler.DragBroken   = fiddle_closure_block_caller(0, [0]) {}
        @area_handler.KeyEvent     = fiddle_closure_block_caller(0, [0]) {}
      end
      
      def area_draw_params_hash(area_draw_params)
        {
          context: area_draw_params.Context,
          area_width: area_draw_params.AreaWidth,
          area_height: area_draw_params.AreaHeight,
          clip_x: area_draw_params.ClipX,
          clip_y: area_draw_params.ClipY,
          clip_width: area_draw_params.ClipWidth,
          clip_height: area_draw_params.ClipHeight,
        }
      end
    end
  end
end
