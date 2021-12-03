require 'glimmer-dsl-libui'

include Glimmer

img = [File.expand_path('../icons/glimmer.png', __dir__), 24, 24] # scales image to 24x24 (can be passed as file path String only instead of Array to avoid scaling)

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
      background_color_column # must be the last column

      cell_rows data
    }
  }
}.show
