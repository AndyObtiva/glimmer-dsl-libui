# Copyright (c) 2021-2023 Andy Maleh
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
require 'glimmer/libui/data_bindable'

module Glimmer
  module LibUI
    class AttributedString
      include DataBindable
      
      attr_reader :keyword, :parent_proxy, :args, :content_added
      attr_accessor :block
      alias content_added? content_added
    
      def initialize(keyword, parent_proxy, args, &block)
        @keyword = keyword
        @parent_proxy = parent_proxy
        @args = args
        @string = @args.first || ''
        @block = block
        post_add_content if @block.nil?
      end
      
      def string(value = nil)
        if value.nil?
          @string
        else
          @string = value
          request_auto_redraw
        end
      end
      alias string= string
      alias set_string string
      
      def font(value = nil)
        if value.nil?
          @font
        else
          @font = value
          request_auto_redraw
        end
      end
      alias font= font
      alias set_font font
      
      def color(value = nil)
        if value.nil?
          @color
        else
          @color = Glimmer::LibUI.interpret_color(value)
          request_auto_redraw
        end
      end
      alias color= color
      alias set_color color
      
      def background(value = nil)
        if value.nil?
          @background
        else
          @background = Glimmer::LibUI.interpret_color(value)
          request_auto_redraw
        end
      end
      alias background= background
      alias set_background background
      
      def underline(value = nil)
        if value.nil?
          @underline
        else
          @underline = value
          request_auto_redraw
        end
      end
      alias underline= underline
      alias set_underline underline
      
      def underline_color(value = nil)
        if value.nil?
          @underline_color
        else
          @underline_color = value
          request_auto_redraw
        end
      end
      alias underline_color= underline_color
      alias set_underline_color underline_color
      
      def open_type_features(value = nil)
        if value.nil?
          @open_type_features
        else
          @open_type_features = value
          request_auto_redraw
        end
      end
      alias open_type_features= open_type_features
      alias set_open_type_features open_type_features
      
      def remove_open_type_features
        return if @removing_open_type_features
        @removing_open_type_features = true
        @open_type_features&.destroy
        @open_type_features = nil
        request_auto_redraw
        @removing_open_type_features = false
      end
      
      def post_add_content(block = nil)
        block ||= @block
        block_result = block&.call
        unless @content_added
          @string = block_result if block_result.is_a?(String)
          @parent_proxy&.post_initialize_child(self)
          @content_added = true
        end
      end
      
      def post_initialize_child(child)
        self.open_type_features = child if child.is_a?(Glimmer::LibUI::ControlProxy::OpenTypeFeaturesProxy)
      end
      
      def draw(area_draw_params)
        @start = ::LibUI.attributed_string_len(@parent_proxy.attributed_string)
        ::LibUI.attributed_string_append_unattributed(@parent_proxy.attributed_string, @string)
        unless color.nil?
          color_attribute = ::LibUI.new_color_attribute(@color[:r].to_f / 255.0, @color[:g].to_f / 255.0, @color[:b].to_f / 255.0, @color[:a] || 1.0)
          ::LibUI.attributed_string_set_attribute(@parent_proxy.attributed_string, color_attribute, @start, @start + @string.size)
        end
        unless background.nil?
          background_attribute = ::LibUI.new_background_attribute(@background[:r].to_f / 255.0, @background[:g].to_f / 255.0, @background[:b].to_f / 255.0, @background[:a] || 1.0)
          ::LibUI.attributed_string_set_attribute(@parent_proxy.attributed_string, background_attribute, @start, @start + @string.size)
        end
        unless underline.nil?
          underline_attribute = ::LibUI.new_underline_attribute(Glimmer::LibUI.enum_symbol_to_value(:underline, @underline))
          ::LibUI.attributed_string_set_attribute(@parent_proxy.attributed_string, underline_attribute, @start, @start + @string.size)
        end
        unless underline_color.nil?
          if Glimmer::LibUI.enum_symbols(:underline_color).include?(underline_color.to_s.to_sym) && underline_color.to_s.to_sym != :custom
            underline_color_attribute = ::LibUI.new_underline_color_attribute(Glimmer::LibUI.enum_symbol_to_value(:underline_color, @underline_color), 0, 0, 0, 0)
            ::LibUI.attributed_string_set_attribute(@parent_proxy.attributed_string, underline_color_attribute, @start, @start + @string.size)
          else
            the_color = Glimmer::LibUI.interpret_color(@underline_color)
            underline_color_attribute = ::LibUI.new_underline_color_attribute(0, the_color[:r].to_f / 255.0, the_color[:g].to_f / 255.0, the_color[:b].to_f / 255.0, the_color[:a] || 1.0)
            ::LibUI.attributed_string_set_attribute(@parent_proxy.attributed_string, underline_color_attribute, @start, @start + @string.size)
          end
        end
        unless font.nil?
          if font[:family]
            family_attribute = ::LibUI.new_family_attribute(font[:family])
            ::LibUI.attributed_string_set_attribute(@parent_proxy.attributed_string, family_attribute, @start, @start + @string.size)
          end
          if font[:size]
            size_attribute = ::LibUI.new_size_attribute(font[:size])
            ::LibUI.attributed_string_set_attribute(@parent_proxy.attributed_string, size_attribute, @start, @start + @string.size)
          end
          if font[:weight]
            weight_attribute = ::LibUI.new_weight_attribute(Glimmer::LibUI.enum_symbol_to_value(:text_weight, font[:weight]))
            ::LibUI.attributed_string_set_attribute(@parent_proxy.attributed_string, weight_attribute, @start, @start + @string.size)
          end
          if font[:italic]
            italic_attribute = ::LibUI.new_italic_attribute(Glimmer::LibUI.enum_symbol_to_value(:text_italic, font[:italic]))
            ::LibUI.attributed_string_set_attribute(@parent_proxy.attributed_string, italic_attribute, @start, @start + @string.size)
          end
          if font[:stretch]
            stretch_attribute = ::LibUI.new_stretch_attribute(Glimmer::LibUI.enum_symbol_to_value(:text_stretch, font[:stretch]))
            ::LibUI.attributed_string_set_attribute(@parent_proxy.attributed_string, stretch_attribute, @start, @start + @string.size)
          end
        end
        unless open_type_features.nil?
          open_type_features_attribute = ::LibUI.new_features_attribute(open_type_features.libui)
          ::LibUI.attributed_string_set_attribute(@parent_proxy.attributed_string, open_type_features_attribute, @start, @start + @string.size)
        end
        destroy if area_proxy.nil?
      end
      
      def destroy
        return if ControlProxy.main_window_proxy&.destroying?
        open_type_features.destroy unless open_type_features.nil?
        @parent_proxy&.children&.delete(self)
      end
      
      def redraw
        area_proxy&.redraw
      end
      
      def request_auto_redraw
        area_proxy&.request_auto_redraw
      end
      
      def area_proxy
        @parent_proxy.parent_proxy
      end
      
      def content(&block)
        Glimmer::DSL::Engine.add_content(self, Glimmer::DSL::Libui::StringExpression.new, @keyword, {post_add_content: true}, &block)
      end
    end
  end
end
