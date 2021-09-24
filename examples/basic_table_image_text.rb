# frozen_string_literal: true

# NOTE:
# This example displays images that can be freely downloaded from the Studio Ghibli website.

require 'glimmer-dsl-libui'
require 'chunky_png'
require 'open-uri'

include Glimmer

IMAGE_ROWS = []

50.times do |i|
  url = format('https://www.ghibli.jp/gallery/thumb-redturtle%03d.png', (i + 1))
  puts "Processing Image: #{url}"
  f = URI.open(url)
  canvas = ChunkyPNG::Canvas.from_io(f)
  f.close
  data = canvas.to_rgba_stream
  width = canvas.width
  height = canvas.height
  img = image(width, height) {
    image_part(data, width, height, width * 4)
  }
  text = url.sub('https://www.ghibli.jp', '')
  IMAGE_ROWS << [[img, text]] # array of dual-value array column cell
rescue StandardError => e
  warn url, e.message
end

window('The Red Turtle', 310, 350, false) {
  horizontal_box {
    table {
      image_text_column('www.ghibli.jp/works/red-turtle')
      
      cell_rows IMAGE_ROWS
    }
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
