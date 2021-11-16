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

# require 'glimmer/libui/control_proxy/path_proxy'
#
# module Glimmer
#   module LibUI
#     class ControlProxy
      ##Proxy for LibUI image custom widget
      
      ##Follows the Proxy Design Pattern
#       class ImageProxy < PathProxy
#         include Glimmer
#
#         attr_reader :width, :height, :data, :pixels, :shapes
#
#         def initialize(keyword, parent, args, &block)
#           @file = args.shift
#           @width = args.shift
#           @height = args.shift
#           super
#         end
#
#         def file(value = nil)
#           if value.nil?
#             @file
#           else
#             @file = value
#             if area_image? && @content_added
#               post_add_content
#               request_auto_redraw
#             end
#           end
#         end
#         alias file= file
#         alias set_file file
#
#         def width(value = nil)
#           if value.nil?
#             @width
#           else
#             @width = value
#             if area_image? && @content_added
#               post_add_content
#               request_auto_redraw
#             end
#           end
#         end
#         alias width= width
#         alias set_width width
#
#         def height(value = nil)
#           if value.nil?
#             @height
#           else
#             @height = value
#             if area_image? && @content_added
#               post_add_content
#               request_auto_redraw
#             end
#           end
#         end
#         alias height= height
#         alias set_height height
#
#         def request_auto_redraw
#           @parent_proxy&.request_auto_redraw if area_image?
#         end
#
#         def post_add_content
#           super
#           if area_image?
#             load_image
#             parse_pixels
#             calculate_shapes
#             draw(nil) unless @parent_proxy.nil?
#             @content_added = true
#           end
#         end
#
#         def draw(area_draw_params)
#           pd @shapes&.size
#           @shapes&.each do |shape|
#             path {
#               rectangle(shape[:x], shape[:y], shape[:width], shape[:height])
#
#               fill shape[:color]
#             }
#           end
#         end
#
#         def area_image?
#           @parent_proxy&.is_a?(AreaProxy) || AreaProxy.current_area_draw_params
#         end
#
#         private
#
#         def build_control
#           super unless area_image?
#         end
#
#         def load_image
#           require 'chunky_png'
#           f = File.open(@file)
#           canvas = ChunkyPNG::Canvas.from_io(f)
#           f.close
#           canvas.resample_nearest_neighbor!(@width, @height) if @width && @height
#           @data = canvas.to_rgba_stream
#           @width = canvas.width
#           @height = canvas.height
#         end
#
#         def parse_pixels
#           @pixels = height.times.map do |y|
#             width.times.map do |x|
#               r = data[(y*width + x)*4].ord
#               g = data[(y*width + x)*4 + 1].ord
#               b = data[(y*width + x)*4 + 2].ord
#               a = data[(y*width + x)*4 + 3].ord
#               {x: x, y: y, color: {r: r, g: g, b: b, a: a}}
#             end
#           end.flatten
#         end
#
#         def calculate_shapes
#           @shapes = []
#           original_pixels = @pixels.dup
#           indexed_original_pixels = Hash[original_pixels.each_with_index.to_a]
#           @pixels.each do |pixel|
#             index = indexed_original_pixels[pixel]
#             @rectangle_start_x ||= pixel[:x]
#             @rectangle_width ||= 1
#             if pixel[:x] < width - 1 && pixel[:color] == original_pixels[index + 1][:color]
#               @rectangle_width += 1
#             else
#               if pixel[:x] > 0 && pixel[:color] == original_pixels[index - 1][:color]
#                 @shapes << {x: @rectangle_start_x, y: pixel[:y], width: @rectangle_width, height: 1, color: pixel[:color]}
#               else
#                 @shapes << {x: pixel[:x], y: pixel[:y], width: 1, height: 1, color: pixel[:color]}
#               end
#               @rectangle_width = 1
#               @rectangle_start_x = pixel[:x] == width - 1 ? 0 : pixel[:x] + 1
#             end
#           end
#           @shapes
#         end
#       end
#     end
#   end
# end
