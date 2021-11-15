# frozen_string_literal: true

require 'glimmer-dsl-libui'
require 'chunky_png'

include Glimmer

f = File.open(File.expand_path('../icons/glimmer.png', __dir__))
canvas = ChunkyPNG::Canvas.from_io(f)
f.close
# canvas.resample_nearest_neighbor!(24, 24)
# canvas.resample_nearest_neighbor!(96, 96)
data = canvas.to_rgba_stream
width = canvas.width
height = canvas.height
color_maps = height.times.map do |y|
  width.times.map do |x|
    r = data[(y*width + x)*4].ord
    g = data[(y*width + x)*4 + 1].ord
    b = data[(y*width + x)*4 + 2].ord
    a = data[(y*width + x)*4 + 3].ord
    {x: x, y: y, color: {r: r, g: g, b: b, a: a}}
  end
end.flatten

puts 'Opening window...'; $stdout.flush

window('Basic Image', 512, 512) {
  area {
    on_draw do |area_draw_params|
      color_maps.each_with_index do |color_map, index|
        @rectangle_start_x ||= color_map[:x]
        @rectangle_start_y ||= color_map[:y]
        @rectangle_width ||= 1
        @rectangle_height ||= 1
        @rectangle_start_x = 0 if color_map[:x] == width
        if color_map[:x] < width - 1 && color_map[:color] == color_maps[index + 1][:color]
          @rectangle_width += 1
        elsif color_map[:x] == width - 1 && @rectangle_start_x == 0 && color_maps[(index + 1)..(index + 1 + width)].map {|cm| cm[:color]}.uniq == [color_map[:color]]
          @rectangle_height += 1
        else
          if color_map[:x] > 0 && color_map[:color] == color_maps[index - 1][:color]
            path {
              # Note: I don't know why I needed to add 1 to start_x to get the right image to display
              rectangle(@rectangle_start_x + 1, @rectangle_start_y, @rectangle_width, @rectangle_height)

              fill color_map[:color]
            }
          else
            path {
              rectangle(color_map[:x], color_map[:y], 1, 1)

              fill color_map[:color]
            }
          end
          @rectangle_width = 1
          @rectangle_height = 1
          @rectangle_start_x = color_map[:x] == width ? 0 : color_map[:x]
          @rectangle_start_y = color_map[:x] == width ? (color_map[:y] == height ? color_map[:y] : color_map[:y]) : color_map[:y]
        end
      end
    end
  }
}.show
