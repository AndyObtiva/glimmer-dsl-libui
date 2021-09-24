# frozen_string_literal: true

# NOTE:
# This example displays images that can be freely downloaded from the Studio Ghibli website.

require 'glimmer-dsl-libui'
require 'chunky_png'
require 'open-uri'

include Glimmer

IMAGES = []

# 50.times do |i|
#   url = format('https://www.ghibli.jp/gallery/thumb-redturtle%03d.png', (i + 1))
#   puts "Processing Image: #{url}"
#   f = URI.open(url)
#   canvas = ChunkyPNG::Canvas.from_io(f)
#   f.close
#   data = canvas.to_rgba_stream
#   width = canvas.width
#   height = canvas.height
#   image = image(width, height) {
#     image_part(image, data, width, height, width * 4)
#   }
#   IMAGES << [image]
# rescue StandardError => e
#   warn url, e.message
# end

window('The Red Turtle', 310, 350, false) {
  horizontal_box {
    table {
      image_column('www.ghibli.jp/works/red-turtle', 0)
      
#       cell_rows IMAGES
    }
    
  }
  on_closing do
    puts 'Bye Bye'
  end
}.show
