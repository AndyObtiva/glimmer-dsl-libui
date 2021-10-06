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
require 'glimmer/libui/control_proxy/area_proxy'
require 'glimmer/libui/parent'
require 'glimmer/libui/control_proxy/transformable'

module Glimmer
  module LibUI
    class AttributedString
      attr_accessor :string
      attr_reader :block, :keyword, :parent_proxy, :args
    
      def initialize(keyword, parent_proxy, args, &block)
        @keyword = keyword
        @parent_proxy = parent_proxy
        @args = args
        @string = @args.first || ''
        @block = block
        post_add_content if @block.nil?
      end
      
      def font(value = nil)
#         UI.attributed_string_set_attribute(@parent_proxy.attributed_string, color_attribute, start, start + @string.size)
      end
      
      def color(value = nil)
        if value.nil?
          @color
        else
          @color = Glimmer::LibUI.interpret_color(value)
        end
      end
      
      def background(value = nil)
#         UI.attributed_string_set_attribute(@parent_proxy.attributed_string, color_attribute, start, start + @string.size)
      end
      
      def underline(value = nil)
#         UI.attributed_string_set_attribute(@parent_proxy.attributed_string, color_attribute, start, start + @string.size)
      end
      
      def post_add_content
        block_result = block&.call
        @string = block_result if block_result.is_a?(String)
        @parent_proxy&.post_initialize_child(self)
      end
      
      def draw(area_draw_params)
        @start = ::LibUI.attributed_string_len(@parent_proxy.attributed_string)
        ::LibUI.attributed_string_append_unattributed(@parent_proxy.attributed_string, @string)
        unless color.nil?
          color_attribute = ::LibUI.new_color_attribute(@color[:r], @color[:g], @color[:b], @color[:a] || 1.0)
          ::LibUI.attributed_string_set_attribute(@parent_proxy.attributed_string, color_attribute, @start, @start + @string.size)
        end
      end
      
      def destroy
        @parent_proxy&.children&.delete(self)
      end
      
      def redraw
        area_proxy&.queue_redraw_all
      end
      
      def area_proxy
        @parent_proxy.parent_proxy
      end
    end
  end
end
