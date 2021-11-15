# frozen_string_literal: true

require 'glimmer-dsl-libui'
require 'chunky_png'

include Glimmer

puts 'Parsing image...'; $stdout.flush

f = File.open(File.expand_path('../icons/glimmer.png', __dir__))
# f = File.open(File.expand_path('../icons/mohawks.png', __dir__))
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

puts 'Parsing shapes...'; $stdout.flush

shape_maps = []
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
      # Note: I don't know why I needed to add 1 to @rectangle_start_x to get the right image to display
      shape_maps << {x: @rectangle_start_x + 1, y: @rectangle_start_y, width: @rectangle_width, height: @rectangle_height, color: color_map[:color]}
    else
      shape_maps << {x: color_map[:x], y: color_map[:y], width: 1, height: 1, color: color_map[:color]}
    end
    @rectangle_width = 1
    @rectangle_height = 1
    @rectangle_start_x = color_map[:x] == width ? 0 : color_map[:x]
    @rectangle_start_y = color_map[:x] == width ? (color_map[:y] == height ? color_map[:y] : color_map[:y]) : color_map[:y]
  end
end
pd shape_maps.size

puts 'Grouping shapes...'; $stdout.flush

skipped_shape_maps = []
grouped_shape_maps = []
shape_maps.each_with_index do |shape_map, index|
  unless skipped_shape_maps.include?(shape_map)
    group = [shape_map]
    group_ended = false
    shape_map_to_group_index = index + 1
    until group_ended || shape_map_to_group_index == shape_maps.size
      shape_map_to_group = shape_maps[shape_map_to_group_index]
      if shape_map_to_group[:color] == group.last[:color] && shape_map_to_group[:x] == group.last[:x] && shape_map_to_group[:width] == group.last[:width] && shape_map_to_group[:y] == group.last[:y] + 1
        group << shape_map_to_group
        skipped_shape_maps << shape_map_to_group
      else
        group_ended = true if shape_map_to_group[:y] > group.last[:y] + 1
      end
      shape_map_to_group_index += 1
    end
    if group.size == 1
      grouped_shape_maps << group.last
    else
      grouped_shape_maps << {x: group.first[:x], y: group.first[:y], width: group.first[:width], height: group.size, color: group.first[:color]}
    end
  end
end
pd grouped_shape_maps.size

puts 'Rendering image...'; $stdout.flush

window('Basic Image', 512, 512) {
  area {
    on_draw do |area_draw_params|
      grouped_shape_maps.each do |shape_map|
        path {
          rectangle(shape_map[:x], shape_map[:y], shape_map[:width], shape_map[:height])

          fill shape_map[:color]
        }
      end
    end
  }
}.show
