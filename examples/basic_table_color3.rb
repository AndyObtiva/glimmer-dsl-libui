require 'glimmer-dsl-libui'
require 'chunky_png'

include Glimmer

f = File.open(File.expand_path('../icons/glimmer.png', __dir__))
canvas = ChunkyPNG::Canvas.from_io(f)
f.close
canvas.resample_nearest_neighbor!(24, 24)
data = canvas.to_rgba_stream
width = canvas.width
height = canvas.height
img = image {
  image_part(data, width, height, width * 4)
}

data = [
  [['cat', :red]      , ['meow', :blue]                  , [true, 'mammal', :green], [img, 'Glimmer', :dark_blue], {r: 255, g: 120, b: 0, a: 0.5}],
  [['dog', :yellow]   , ['woof', {r: 240, g: 32, b: 32}] , [true, 'mammal', :green], [img, 'Glimmer', :dark_blue], :skyblue],
  [['chicken', :beige], ['cock-a-doodle-doo', :blue]     , [false, 'mammal', :red] , [img, 'Glimmer', :beige], {r: 5, g: 120, b: 110}],
  [['horse', :purple] , ['neigh', {r: 240, g: 32, b: 32}], [true, 'mammal', :green], [img, 'Glimmer', :dark_blue], '13a1fb'],
  [['cow', :gray]     , ['moo', :blue]                   , [true, 'mammal', :green], [img, 'Glimmer', :brown], 0x12ff02]
]

window('Animals', 500, 200) {
  horizontal_box {
    table {
      text_color_column('Animal')
      text_color_column('Sound')
      checkbox_text_color_column('Description')
      image_text_color_column('GUI')
      background_color_column('Mammal')

      cell_rows data
    }
  }
}.show
