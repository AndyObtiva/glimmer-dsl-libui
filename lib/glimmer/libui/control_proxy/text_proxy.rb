# Copyright (c) 2021-2024 Andy Maleh
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
    class ControlProxy
      # Proxy for LibUI text objects
      #
      # Follows the Proxy Design Pattern
      class TextProxy < ControlProxy
        include Parent
        include PerfectShaped
        prepend Transformable
        
        def initialize(keyword, parent, args, &block)
          @keyword = keyword
          @parent_proxy = parent
          @args = args
          @block = block
          post_add_content if @block.nil?
        end
      
        def post_add_content
          super
          if @parent_proxy.nil? && AreaProxy.current_area_draw_params
            draw(AreaProxy.current_area_draw_params)
            destroy
          end
        end
        
        def draw(area_draw_params)
          reset_attributed_string
          children.dup.each {|child| child.draw(area_draw_params)}
          build_control
          ::LibUI.draw_text(area_draw_params[:context], @libui, x, y)
          ::LibUI.draw_free_text_layout(@libui)
          ::LibUI.free_attributed_string(@attributed_string)
        end
        
        def destroy
          return if ControlProxy.main_window_proxy&.destroying?
          deregister_all_custom_listeners
          @parent_proxy&.children&.delete(self)
          ControlProxy.control_proxies.delete(self)
        end
        
        def redraw
          @parent_proxy&.queue_redraw_all
        end
        
        def x(value = nil)
          if value.nil?
            @x ||= args[0] || 0
          else
            @x = value
          end
        end
        alias x= x
        alias set_x x
        
        def y(value = nil)
          if value.nil?
            @y ||= args[1] || 0
          else
            @y = value
          end
        end
        alias y= y
        alias set_y y
        
        def width(value = nil)
          if value.nil?
            @width ||= args[2] || (AreaProxy.current_area_draw_params && (AreaProxy.current_area_draw_params[:area_width] - 2*x))
          else
            @width = value
            redraw
          end
        end
        alias width= width
        alias set_width width
        
        def attributed_string
          @attributed_string ||= reset_attributed_string
        end
        
        def reset_attributed_string
          @attributed_string = ::LibUI.new_attributed_string('')
        end
        
        def default_font(value = nil)
          if value.nil?
            @default_font ||= {
              family: 'Helvetica',
              size: 12.0,
              weight: :normal,
              italic: :normal,
              stretch: :normal,
            }
          else
            @default_font = value
            redraw
          end
        end
        alias default_font= default_font
        alias set_default_font default_font
        
        def default_font_descriptor
          @default_font_descriptor ||= ::LibUI::FFI::FontDescriptor.malloc
          @default_font_descriptor.Family = default_font[:family] || 'Helvetica'
          @default_font_descriptor.Size = default_font[:size] || 12.0
          @default_font_descriptor.Weight = Glimmer::LibUI.enum_symbol_to_value(:text_weight, default_font[:weight], default_symbol: :normal)
          @default_font_descriptor.Italic = Glimmer::LibUI.enum_symbol_to_value(:text_italic, default_font[:italic], default_symbol: :normal)
          @default_font_descriptor.Stretch = Glimmer::LibUI.enum_symbol_to_value(:text_stretch, default_font[:stretch], default_symbol: :normal)
          @default_font_descriptor
        end
        
        def align(value = nil)
          if value.nil?
            @align
          else
            @align = value
            redraw
          end
        end
        alias align= align
        alias set_align align
        
        def draw_text_layout_params
          @draw_text_layout_params ||= ::LibUI::FFI::DrawTextLayoutParams.malloc
          @draw_text_layout_params.String = attributed_string
          @draw_text_layout_params.DefaultFont = default_font_descriptor
          @draw_text_layout_params.Width = width
          @draw_text_layout_params.Align = Glimmer::LibUI.enum_symbol_to_value(:draw_text_align, align, default_symbol: :left)
          @draw_text_layout_params
        end
        
        def area_proxy
          # TODO eventually reuse this method from Shape
          find_parent_in_ancestors { |parent| parent.nil? || parent.is_a?(ControlProxy::AreaProxy) }
        end
        
        def find_parent_in_ancestors(&condition)
          # TODO eventually reuse this method from Shape
          found = self
          until condition.call(found)
            # TODO in the future, support nesting under composite shape where there is parent instead of parent_proxy
#             found = found.respond_to?(:parent_proxy) ? found.parent_proxy : found.parent
            found = found.parent_proxy
          end
          found
        end
      
        def can_handle_listener?(listener_name)
          area_proxy&.can_handle_listener?(listener_name)
        end
        
        def handle_listener(listener_name, &listener)
          area_proxy.handle_listener(listener_name) do |event|
            listener.call(event) if include?(event[:x], event[:y])
          end
        end
        
        def perfect_shape
          require 'perfect-shape'
          the_perfect_shape_dependencies = perfect_shape_dependencies
          if the_perfect_shape_dependencies != @perfect_shape_dependencies
            absolute_x, absolute_y, width, height = @perfect_shape_dependencies = the_perfect_shape_dependencies
            @perfect_shape = PerfectShape::Rectangle.new(x: absolute_x, y: absolute_y, width: width, height: height)
          end
          @perfect_shape
        end
        
        def perfect_shape_dependencies
          # TODO support absolute_x and absolute_y with relative positioning in the future
          absolute_x = x
          absolute_y = y
          [absolute_x, absolute_y, extent_width, extent_height]
        end
        
        def extent_width
          if @extent_width.to_f > 0
            @extent_width
          else # TODO auto calculate extents
            width
          end
        end
        
        def extent_height
          if @extent_height.to_f > 0
            @extent_height
          else # TODO auto calculate extents
            children_max_size = children.map(&:font).map {|font| font[:size] if font.respond_to?(:[]) }.compact.max
            if children_max_size.to_f > 0
              children_max_size
            else
              @default_font[:size]
            end
          end
        end
        
        def calculate_extents
          # TODO fix implementation once libui binding project responds about this
          # as it always returns 0,0 right now
          extent_width = Fiddle::Pointer.malloc(Fiddle::SIZEOF_DOUBLE*8)
          extent_height = Fiddle::Pointer.malloc(Fiddle::SIZEOF_DOUBLE*8)
          ::LibUI.draw_text_layout_extents(@libui, extent_width, extent_height)
          @extent_width = extent_width[0, Fiddle::SIZEOF_DOUBLE*8].unpack1('i')
          @extent_height = extent_height[0, Fiddle::SIZEOF_DOUBLE*8].unpack1('i')
        end
        
        private
        
        def build_control
          @libui = ::LibUI.draw_new_text_layout(draw_text_layout_params)
        end
        
        def init_draw_brush(draw_brush, draw_brush_args)
          draw_brush.Type = Glimmer::LibUI.enum_symbol_to_value(:draw_brush_type, draw_brush_args[:type])
          draw_brush.R = (draw_brush_args[:r] || draw_brush_args[:red]).to_f / 255.0
          draw_brush.G = (draw_brush_args[:g] || draw_brush_args[:green]).to_f / 255.0
          draw_brush.B = (draw_brush_args[:b] || draw_brush_args[:blue]).to_f / 255.0
          draw_brush.A = (draw_brush_args[:a] || draw_brush_args[:alpha])
        end
      end
    end
  end
end
