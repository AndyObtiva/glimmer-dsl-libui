# frozen_string_literal: true

require 'glimmer-dsl-libui'
require 'chunky_png'

include Glimmer

puts 'Parsing image...'; $stdout.flush

f = File.open(File.expand_path('../icons/glimmer.png', __dir__))
canvas = ChunkyPNG::Canvas.from_io(f)
f.close
# canvas.resample_nearest_neighbor!(24, 24)
# canvas.resample_nearest_neighbor!(96, 96)
data = canvas.to_rgba_stream
width = canvas.width
height = canvas.height

puts 'Parsing colors...'; $stdout.flush

color_maps = height.times.map do |y|
  width.times.map do |x|
    r = data[(y*width + x)*4].ord
    g = data[(y*width + x)*4 + 1].ord
    b = data[(y*width + x)*4 + 2].ord
    a = data[(y*width + x)*4 + 3].ord
    {x: x, y: y, color: {r: r, g: g, b: b, a: a}}
  end
end.flatten
puts "#{color_maps.size} pixels to render..."; $stdout.flush

puts 'Parsing shapes...'; $stdout.flush

shape_maps = []
original_color_maps = color_maps.dup
indexed_original_color_maps = Hash[original_color_maps.each_with_index.to_a]
color_maps.each do |color_map|
  index = indexed_original_color_maps[color_map]
  @rectangle_start_x ||= color_map[:x]
  @rectangle_start_y ||= color_map[:y]
  @rectangle_width ||= 1
  @rectangle_height ||= 1
  if color_map[:x] < width - 1 && color_map[:color] == original_color_maps[index + 1][:color]
    @rectangle_width += 1
  else
    if color_map[:x] > 0 && color_map[:color] == original_color_maps[index - 1][:color]
      groupable_color_map_y = @rectangle_start_y + 1
      while groupable_color_map_y < height && (deletable_color_maps = original_color_maps[(groupable_color_map_y*width + @rectangle_start_x), @rectangle_width].to_a).all? {|cm| cm[:color] == color_map[:color]}
        @rectangle_height += 1
        groupable_color_map_y += 1
        (@rectangle_start_x...(@rectangle_start_x + @rectangle_width)).each do |x|
          index_to_delete = groupable_color_map_y*width + x
          color_maps.delete_at(index_to_delete)
        end
      end
      shape_maps << {x: @rectangle_start_x, y: @rectangle_start_y, width: @rectangle_width, height: @rectangle_height, color: color_map[:color]}
    else
      shape_maps << {x: color_map[:x], y: color_map[:y], width: 1, height: 1, color: color_map[:color]}
    end
    @rectangle_width = 1
    @rectangle_height = 1
    @rectangle_start_x = color_map[:x] == width - 1 ? 0 : color_map[:x] + 1
    @rectangle_start_y = color_map[:x] == width - 1 ? color_map[:y] + 1 : color_map[:y]
  end
end
pd color_maps.size
pd original_color_maps.size
puts "#{shape_maps.size} shapes to render..."; $stdout.flush

puts 'Rendering image...'; $stdout.flush

window('Basic Image', 512, 512) {
  area {
    on_draw do |area_draw_params|
      shape_maps.each do |shape_map|
        path {
          rectangle(shape_map[:x], shape_map[:y], shape_map[:width], shape_map[:height])

          fill shape_map[:color]
        }
      end
    end
  }
}.show
