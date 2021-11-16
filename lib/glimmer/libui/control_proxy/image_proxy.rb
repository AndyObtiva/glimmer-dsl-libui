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
require 'glimmer/libui/image_path_renderer'
require 'glimmer/data_binding/observer'
require 'glimmer/libui/control_proxy/transformable'

using ArrayIncludeMethods

module Glimmer
  module LibUI
    class ControlProxy
      # Proxy for LibUI image object and Glimmer custom control
      #
      # Follows the Proxy Design Pattern
      class ImageProxy < ControlProxy
        include Parent
        prepend Transformable
        
        attr_reader :data, :pixels, :shapes
        
        def initialize(keyword, parent, args, &block)
          @keyword = keyword
          @parent_proxy = parent
          @args = args
          @block = block
          @enabled = true
          post_add_content if @block.nil?
        end
                
        def post_add_content
          if area_image?
            @shapes = nil
            super
            if @parent_proxy.nil? && AreaProxy.current_area_draw_params
              draw(AreaProxy.current_area_draw_params)
              destroy
            end
            @content_added = true
          else # image object not control
            build_control
            super
          end
        end
        
        def file(value = nil)
          if area_image?
            if value.nil?
              @args[0]
            else
              @args[0] = value
              if @content_added
                post_add_content
                request_auto_redraw
              end
            end
          end
        end
        alias file= file
        alias set_file file
      
        def width(value = nil)
          if value.nil?
            area_image? ? @args[1] : @args[0]
          else
            if area_image?
              @args[1] = value
              if @content_added
                post_add_content
                request_auto_redraw
              end
            else
              @args[0] = value
            end
          end
        end
        alias width= width
        alias set_width width
      
        def height(value = nil)
          if value.nil?
            area_image? ? @args[2] : @args[1]
          else
            if area_image?
              @args[2] = value
              if @content_added
                post_add_content
                request_auto_redraw
              end
            else
              @args[1] = value
            end
          end
        end
        alias height= height
        alias set_height height
        
        def redraw
          @parent_proxy&.redraw
        end
        
        def request_auto_redraw
          @parent_proxy&.request_auto_redraw if area_image?
        end
      
        def draw(area_draw_params)
          if @shapes.nil?
            load_image
            parse_pixels
            calculate_shapes
          end
          ImagePathRenderer.new(@parent_proxy, @shapes).render
        end
        
        def area_image?
          @parent_proxy&.is_a?(AreaProxy) or
            AreaProxy.current_area_draw_params or
            @args[0].is_a?(String) # first arg is file
        end
        
        def destroy
          @parent_proxy&.children&.delete(self)
          ControlProxy.control_proxies.delete(self)
        end
        
        private
        
        def build_control
          unless area_image? # image object
            @args = [@children.first.args[1], @children.first.args[2]] if @children.size == 1 && (@args[0].nil? || @args[1].nil?)
            super
            @libui.tap do
              @children.each {|child| child&.send(:build_control) }
            end
          end
        end
        
        def load_image
          require 'chunky_png'
          f = File.open(file)
          canvas = ChunkyPNG::Canvas.from_io(f)
          f.close
          canvas.resample_nearest_neighbor!(width, height) if width && height
          @data = canvas.to_rgba_stream
          self.width = canvas.width
          self.height = canvas.height
        end
        
        def parse_pixels
          @pixels = height.times.map do |y|
            width.times.map do |x|
              r = @data[(y*width + x)*4].ord
              g = @data[(y*width + x)*4 + 1].ord
              b = @data[(y*width + x)*4 + 2].ord
              a = @data[(y*width + x)*4 + 3].ord
              {x: x, y: y, color: {r: r, g: g, b: b, a: a}}
            end
          end.flatten
        end
        
        def calculate_shapes
          @shapes = []
          original_pixels = @pixels.dup
          indexed_original_pixels = Hash[original_pixels.each_with_index.to_a]
          @pixels.each do |pixel|
            index = indexed_original_pixels[pixel]
            @rectangle_start_x ||= pixel[:x]
            @rectangle_width ||= 1
            if pixel[:x] < width - 1 && pixel[:color] == original_pixels[index + 1][:color]
              @rectangle_width += 1
            else
              if pixel[:x] > 0 && pixel[:color] == original_pixels[index - 1][:color]
                @shapes << {x: @rectangle_start_x, y: pixel[:y], width: @rectangle_width, height: 1, color: pixel[:color]}
              else
                @shapes << {x: pixel[:x], y: pixel[:y], width: 1, height: 1, color: pixel[:color]}
              end
              @rectangle_width = 1
              @rectangle_start_x = pixel[:x] == width - 1 ? 0 : pixel[:x] + 1
            end
          end
          @shapes
        end
      end
    end
  end
end
