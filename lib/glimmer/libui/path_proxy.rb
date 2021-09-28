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
      
      def post_add_content
        super
        if @parent_proxy.nil? && area_draw_params
          draw(area_draw_params)
          destroy
        end
      end
      
      def children
        @children ||= []
      end
      
      def draw(area_draw_params)
        build_control
        children.each {|child| child.draw(area_draw_params)}
        ::LibUI.draw_path_end(@libui)
        ::LibUI.draw_fill(area_draw_params[:context], @libui, fill_draw_brush.to_ptr) unless fill.empty?
        ::LibUI.draw_stroke(area_draw_params[:context], @libui, stroke_draw_brush, draw_stroke_params) unless stroke.empty?
        ::LibUI.draw_free_path(@libui)
      end
      
      def draw_fill_mode
        @args[0].is_a?(Integer) ? @args[0] : @args[0].to_s == 'alternate' ? 1 : 0
      end
      
      def fill(args = nil)
        if args.nil?
          @fill ||= {}
        else
          @fill = args
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
    
      def stroke(args = nil)
        if args.nil?
          @stroke ||= {}
        else
          @stroke = args
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
        @draw_stroke_params.Cap = @stroke[:cap] || 0 # flat
        @draw_stroke_params.Join = @stroke[:join] || 0 # miter
        @draw_stroke_params.Thickness = @stroke[:thickness] || 1
        @draw_stroke_params.MiterLimit = @stroke[:miter_limit] || 10 # DEFAULT_MITER_LIMIT
        @draw_stroke_params_dashes ||= Fiddle::Pointer.malloc(8)
        @draw_stroke_params.Dashes = @draw_stroke_params_dashes
        @draw_stroke_params.NumDashes = @stroke[:num_dashes] || 0 # TODO reimplement this line correctly (perhaps no need to pass num dashes, yet dashes themselves and use their count here)
        @draw_stroke_params.DashPhase = @stroke[:dash_phase] || 0
        @draw_stroke_params
      end
      
      # returns area_draw_params if built inside on_draw listener (not needed if declared outside)
      def area_draw_params
        @args[0] if @parent_proxy.nil?
      end
    
      def destroy
        @parent_proxy.children.delete(self) unless @parent_proxy.nil?
        ControlProxy.control_proxies.delete(self)
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
