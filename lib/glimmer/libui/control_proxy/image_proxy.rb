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
require 'glimmer/libui/control_proxy/image_part_proxy'
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
        class << self
          # creates or returns existing instance for passed in arguments if parent is nil and block is nil
          def create(keyword, parent, args, &block)
            if parent.nil? && block.nil?
              instances[args] ||= new(keyword, parent, args.dup, &block)
            else
              new(keyword, parent, args, &block)
            end
          end
          
          def instances
            @@instances = {} unless defined? @@instances
            @@instances
          end
        end
        
        include Parent
        prepend Transformable
        include Equalizer.new(:options, :data)
        
        attr_reader :data, :pixels, :shapes, :options
        
        def initialize(keyword, parent, args, &block)
          @keyword = keyword
          @parent_proxy = parent
          @options = args.last.is_a?(Hash) ? args.pop : {}
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
          else # image object not control
            build_control unless @content_added
            super
          end
        end
        
        def file(value = nil)
          if value.nil?
            @args[0]
          else
            @args[0] = value
            if area_image? && @content_added
              post_add_content
              request_auto_redraw
            end
          end
        end
        alias file= file
        alias set_file file
      
        def x(value = nil)
          if value.nil?
            @args.size > 3 ? @args[1] : (@options[:x] || 0)
          else
            if @args.size > 3
              @args[1] = value
            else
              @options[:x] = value
            end
            if area_image? && @content_added
              post_add_content
              request_auto_redraw
            end
          end
        end
        alias x= x
        alias set_x x
      
        def y(value = nil)
          if value.nil?
            @args.size > 3 ? @args[2] : (@options[:y] || 0)
          else
            if @args.size > 3
              @args[2] = value
            else
              @options[:y] = value
            end
            if area_image? && @content_added
              post_add_content
              request_auto_redraw
            end
          end
        end
        alias y= y
        alias set_y y
        
        def width(value = nil)
          if value.nil?
            @args.size > 3 ? @args[3] : (@options[:width] || @args[1])
          else
            set_width_variable(value)
            if area_image? && @content_added
              post_add_content
              request_auto_redraw
            end
          end
        end
        alias width= width
        alias set_width width
      
        def height(value = nil)
          if value.nil?
            @args.size > 3 ? @args[4] : (@options[:height] || @args[2])
          else
            set_height_variable(value)
            if area_image? && @content_added
              post_add_content
              request_auto_redraw
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
          @area_image ||= !!(@parent_proxy&.is_a?(AreaProxy) || AreaProxy.current_area_draw_params)
        end
        
        def destroy
          return if ControlProxy.main_window_proxy&.destroying?
          deregister_all_custom_listeners
          @parent_proxy&.children&.delete(self)
          ControlProxy.control_proxies.delete(self)
        end
        
        private
        
        def set_width_variable(value)
          if @args.size > 3
            @args[3] = value
          elsif @options[:width]
            @options[:width] = value
          else
            @args[1] = value
          end
        end
        
        def set_height_variable(value)
          if @args.size > 3
            @args[4] = value
          elsif @options[:height]
            @options[:height] = value
          else
            @args[2] = value
          end
        end
        
        def build_control
          unless area_image? # image object
            if file
              load_image
              ImagePartProxy.new('image_part', self, [@data, width, height, width * 4])
            end
            @args[1] = @children.first.args[1] if @children.size == 1 && @args[1].nil?
            @args[2] = @children.first.args[2] if @children.size == 1 && @args[2].nil?
            @libui = ControlProxy.new_control(@keyword, [width, height])
            @libui.tap do
              @children.each {|child| child&.send(:build_control) }
            end
          end
        rescue => e
          Glimmer::Config.logger.error {"Failed to load image file: #{file}"}
          Glimmer::Config.logger.error {e.full_message}
          raise e
        end
        
        def load_image
          require 'chunky_png'
          canvas = nil
          if file.start_with?('http')
            require 'net/http'
            require 'open-uri'
            uri = URI(file)
            canvas = ChunkyPNG::Canvas.from_string(Net::HTTP.get(uri))
          else
            f = File.open(file)
            canvas = ChunkyPNG::Canvas.from_io(f)
            f.close
          end
          original_width = canvas.width
          original_height = canvas.height
          require 'bigdecimal'
          calculated_width = ((BigDecimal(height)/BigDecimal(original_height))*original_width).to_i if height && !width
          calculated_height = ((BigDecimal(width)/BigDecimal(original_width))*original_height).to_i if width && !height
          canvas.resample_nearest_neighbor!(calculated_width || width, calculated_height || height) if width || height
          @data = canvas.to_rgba_stream
          set_width_variable(canvas.width) unless width
          set_height_variable(canvas.height) unless height
          [@data, width, height]
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
          x_offset = x
          y_offset = y
          @pixels.each do |pixel|
            index = indexed_original_pixels[pixel]
            @rectangle_start_x ||= pixel[:x]
            @rectangle_width ||= 1
            if pixel[:x] < width - 1 && pixel[:color] == original_pixels[index + 1][:color]
              @rectangle_width += 1
            else
              if pixel[:x] > 0 && pixel[:color] == original_pixels[index - 1][:color]
                @shapes << {x: x_offset + @rectangle_start_x, y: y_offset + pixel[:y], width: @rectangle_width, height: 1, color: pixel[:color]}
              else
                @shapes << {x: x_offset + pixel[:x], y: y_offset + pixel[:y], width: 1, height: 1, color: pixel[:color]}
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
