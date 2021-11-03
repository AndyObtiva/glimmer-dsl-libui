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
            new_color = Glimmer::LibUI.interpret_color(args)
            if new_color != @fill
              @fill = new_color
              request_auto_redraw
            end
          end
          @fill.tap do
            @fill_observer ||= Glimmer::DataBinding::Observer.proc do
              request_auto_redraw
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
            new_color = Glimmer::LibUI.interpret_color(args)
            if new_color != @stroke
              @stroke = Glimmer::LibUI.interpret_color(args)
              request_auto_redraw
            end
          end
          @stroke.tap do
            @stroke_observer ||= Glimmer::DataBinding::Observer.proc do
              request_auto_redraw
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
          Glimmer::LibUI.enum_symbol_to_value(:draw_line_cap, @stroke && @stroke[:cap])
        end
        
        def draw_line_join
          Glimmer::LibUI.enum_symbol_to_value(:draw_line_join, @stroke && @stroke[:join])
        end
        
        def destroy
          @parent_proxy&.children&.delete(self)
          ControlProxy.control_proxies.delete(self)
        end
        
        def redraw
          @parent_proxy&.redraw
        end
        
        def request_auto_redraw
          @parent_proxy&.request_auto_redraw
        end
        
        private
        
        def build_control
          @libui = ::LibUI.draw_new_path(draw_fill_mode)
        end
        
        def init_draw_brush(draw_brush, draw_brush_args)
          if draw_brush_args[:r] || draw_brush_args[:g] || draw_brush_args[:b] || draw_brush_args[:a]
            draw_brush_args[:type] ||= :solid
          elsif draw_brush_args[:outer_radius]
            draw_brush_args[:type] ||= :radial_gradient
          else
            draw_brush_args[:type] ||= :linear_gradient
          end
          draw_brush.Type = Glimmer::LibUI.enum_symbol_to_value(:draw_brush_type, draw_brush_args[:type])
          if draw_brush.Type == 0
            draw_brush.R = (draw_brush_args[:r] || draw_brush_args[:red]).to_f / 255.0
            draw_brush.G = (draw_brush_args[:g] || draw_brush_args[:green]).to_f / 255.0
            draw_brush.B = (draw_brush_args[:b] || draw_brush_args[:blue]).to_f / 255.0
            draw_brush.A = (draw_brush_args[:a] || draw_brush_args[:alpha] || 1.0)
          else
            draw_brush.X0 = draw_brush_args[:x0].to_f
            draw_brush.Y0 = draw_brush_args[:y0].to_f
            draw_brush.X1 = draw_brush_args[:x1].to_f
            draw_brush.Y1 = draw_brush_args[:y1].to_f
            draw_brush.OuterRadius = draw_brush_args[:outer_radius].to_f if draw_brush.Type == 2
            stop_structs = draw_brush_args[:stops].to_a.map do |stop|
              ::LibUI::FFI::DrawBrushGradientStop.malloc.tap do |stop_struct|
                stop_struct.Pos = stop[:pos].to_f
                stop_color = Glimmer::LibUI.interpret_color(stop)
                stop_struct.R = stop_color[:r].to_f / 255.0
                stop_struct.G = stop_color[:g].to_f / 255.0
                stop_struct.B = stop_color[:b].to_f / 255.0
                stop_struct.A = stop_color[:a] || 1.0
              end
            end
            draw_brush.NumStops = stop_structs.count
            draw_brush.Stops = stop_structs.map(&:to_ptr).map(&:to_s).reduce(:+)
          end
        end
      end
    end
  end
end
