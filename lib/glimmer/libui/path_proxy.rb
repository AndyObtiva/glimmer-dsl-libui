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
    # Proxy for LibUI path objects
    #
    # Follows the Proxy Design Pattern
    class PathProxy < ControlProxy
      # TODO support mode without parent proxy
      def initialize(keyword, parent, args, &block)
        @keyword = keyword
        @parent_proxy = parent
        @args = args
        @block = block
        @enabled = true
        post_add_content if @block.nil?
      end
    
      def post_initialize_child(child)
        super
        children << child
      end
      
      def children
        @children ||= []
      end
      
      def draw(area_draw_params)
        build_control
        children.each {|child| child.draw(area_draw_params)}
        ::LibUI.draw_path_end(@libui)
        ::LibUI.draw_fill(area_draw_params.Context, @libui, fill_brush.to_ptr)
        ::LibUI.draw_free_path(@libui)
      end
      
      def draw_fill_mode
        @args[0].is_a?(Integer) ? @args[0] : @args[0].to_s == 'alternate' ? 1 : 0
      end
      
      def fill(args)
        if args.nil?
          @fill_args
        else
          @fill_args = args
        end
      end
      
      def fill_brush
        @fill_brush ||= ::LibUI::FFI::DrawBrush.malloc
        case @fill_args[:type]
        when Integer
          @fill_brush.Type = @fill_args[:type]
        when :solid, 'solid'
          @fill_brush.Type = 0
        when :linear_gradient, 'linear_gradient'
          @fill_brush.Type = 1
        when :radial_gradient, 'radial_gradient'
          @fill_brush.Type = 2
        when :image, 'image'
          @fill_brush.Type = 3
        else
          @fill_brush.Type = 0
        end
        @fill_brush.R = (@fill_args[:r] || @fill_args[:red]).to_f / 255.0
        @fill_brush.G = (@fill_args[:g] || @fill_args[:green]).to_f / 255.0
        @fill_brush.B = (@fill_args[:b] || @fill_args[:blue]).to_f / 255.0
        @fill_brush.A = (@fill_args[:a] || @fill_args[:alpha])
        @fill_brush
      end
    
      def stroke(*args)
        if args.empty?
          @stroke_args
        else
          @stroke_args = args
        end
      end
      
      def destroy
        if @parent_proxy
          @parent_proxy.children.delete(self)
        end
      end
    
      private
      
      def build_control
        @libui = ::LibUI.draw_new_path(draw_fill_mode)
      end
    end
  end
end
