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
    class ControlProxy
      # Proxy for LibUI path objects
      #
      # Follows the Proxy Design Pattern
      class PathProxy < ControlProxy
        include Parent
        prepend Transformable
      
        # TODO support mode without parent proxy
        def initialize(keyword, parent, args, &block)
          @keyword = keyword
          @parent_proxy = parent
          @args = args
          @block = block
          @enabled = true
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
          build_control
          children.dup.each {|child| child.draw(area_draw_params)}
          ::LibUI.draw_path_end(@libui)
          ::LibUI.draw_fill(area_draw_params[:context], @libui, fill_draw_brush.to_ptr) unless fill.empty?
          ::LibUI.draw_stroke(area_draw_params[:context], @libui, stroke_draw_brush, draw_stroke_params) unless stroke.empty?
          ::LibUI.draw_free_path(@libui)
        end
        
        def draw_fill_mode
          @args[0].is_a?(Integer) ? @args[0] : @args[0].to_s == 'alternate' ? 1 : 0
        end
        
        def fill(*args)
          args = args.first if args.size == 1 && (args.first.is_a?(Array) || args.first.is_a?(Hash) || args.first.is_a?(String) || args.first.is_a?(Symbol))
          if args.empty?
            @fill ||= {}
          else
            @fill = Glimmer::LibUI.interpret_color(args)
            @fill[:a] = 1.0 if @fill.is_a?(Hash) && @fill[:a].nil?
            @parent_proxy&.queue_redraw_all
          end
          @fill.tap do
            @fill_observer ||= Glimmer::DataBinding::Observer.proc do
              @parent_proxy&.queue_redraw_all
            end
            @fill_observer.observe(@fill)
          end
        end
        alias fill= fill
        alias set_fill fill
        
        def fill_draw_brush
          @fill_draw_brush ||= ::LibUI::FFI::DrawBrush.malloc
          init_draw_brush(@fill_draw_brush, @fill)
          @fill_draw_brush
        end
      
        def stroke(*args)
          args = args.first if args.size == 1 && (args.first.is_a?(Array) || args.first.is_a?(Hash) || args.first.is_a?(String) || args.first.is_a?(Symbol))
          if args.empty?
            @stroke ||= {}
          else
            @stroke = Glimmer::LibUI.interpret_color(args)
            @stroke[:a] = 1.0 if @stroke.is_a?(Hash) && @stroke[:a].nil?
            @parent_proxy&.queue_redraw_all
          end
          @stroke.tap do
            @stroke_observer ||= Glimmer::DataBinding::Observer.proc do
              @parent_proxy&.queue_redraw_all
            end
            @stroke_observer.observe(@stroke)
          end
        end
        alias stroke= stroke
        alias set_stroke stroke
        
        def stroke_draw_brush
          @stroke_draw_brush ||= ::LibUI::FFI::DrawBrush.malloc
          init_draw_brush(@stroke_draw_brush, @stroke)
          @stroke_draw_brush
        end
        
        def draw_stroke_params
          @draw_stroke_params ||= ::LibUI::FFI::DrawStrokeParams.malloc
          @draw_stroke_params.Cap = draw_line_cap # flat
          @draw_stroke_params.Join = draw_line_join # miter
          @draw_stroke_params.Thickness = @stroke[:thickness] || 1
          @draw_stroke_params.MiterLimit = @stroke[:miter_limit] || 10 # DEFAULT_MITER_LIMIT
          @draw_stroke_params.Dashes = @stroke[:dashes].to_a.pack('d*')
          @draw_stroke_params.NumDashes = @stroke[:dashes].to_a.count
          @draw_stroke_params.DashPhase = @stroke[:dash_phase] || 0
          @draw_stroke_params
        end
        
        def draw_line_cap
          case @stroke && @stroke[:cap].to_s
          when 'round'
            1
          when 'square'
            2
          else # 'flat'
            0
          end
        end
        
        def draw_line_join
          case @stroke && @stroke[:join].to_s
          when 'round'
            1
          when 'bevel'
            2
          else # 'miter'
            0
          end
        end
        
        def destroy
          @parent_proxy&.children&.delete(self)
          ControlProxy.control_proxies.delete(self)
        end
        
        def redraw
          @parent_proxy&.queue_redraw_all
        end
        
        private
        
        def build_control
          @libui = ::LibUI.draw_new_path(draw_fill_mode)
        end
        
        def init_draw_brush(draw_brush, draw_brush_args)
          case draw_brush_args[:type]
          when Integer
            draw_brush.Type = draw_brush_args[:type]
          when :solid, 'solid'
            draw_brush.Type = 0
          when :linear_gradient, 'linear_gradient'
            draw_brush.Type = 1
          when :radial_gradient, 'radial_gradient'
            draw_brush.Type = 2
          when :image, 'image'
            draw_brush.Type = 3
          else
            draw_brush.Type = 0
          end
          draw_brush.R = (draw_brush_args[:r] || draw_brush_args[:red]).to_f / 255.0
          draw_brush.G = (draw_brush_args[:g] || draw_brush_args[:green]).to_f / 255.0
          draw_brush.B = (draw_brush_args[:b] || draw_brush_args[:blue]).to_f / 255.0
          draw_brush.A = (draw_brush_args[:a] || draw_brush_args[:alpha])
        end
      end
    end
  end
end
