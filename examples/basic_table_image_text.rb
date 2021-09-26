# frozen_string_literal: true

# NOTE:
# This example displays images that can be freely downloaded from the Studio Ghibli website.

require 'glimmer-dsl-libui'
require 'chunky_png'
require 'open-uri'

include Glimmer

IMAGE_ROWS = []

5.times do |i|
  url = format('https://www.ghibli.jp/gallery/thumb-redturtle%03d.png', (i + 1))
  puts "Processing Image: #{url}"
  f = URI.open(url)
  canvas = ChunkyPNG::Canvas.from_io(f)
  f.close
  data = canvas.to_rgba_stream
  width = canvas.width
  height = canvas.height
  img = image {
    image_part(data, width, height, width * 4)
  }
  text = url.sub('https://www.ghibli.jp/gallery/thumb-redturtle', '').sub('.png', '')
  IMAGE_ROWS << [[img, text], [img, text]] # cell values are dual-element arrays
rescue StandardError => e
  warn url, e.message
end

window('The Red Turtle', 670, 350) {
  horizontal_box {
    table {
      image_text_column('image/number')
      image_text_column('image/number (editable)') {
        editable true
      }
      
      cell_rows IMAGE_ROWS
    }
  }
}.show
