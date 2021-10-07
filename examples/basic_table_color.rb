# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

data = [
  [['cat', :red]      , ['meow', :blue]                  , [true, 'mammal', :green], {r: 255, g: 120, b: 0, a: 0.5}],
  [['dog', :yellow]   , ['woof', {r: 240, g: 32, b: 32}] , [true, 'mammal', :green], :skyblue],
  [['chicken', :beige], ['cock-a-doodle-doo', :blue]     , [false, 'mammal', :red] , {r: 5, g: 120, b: 110}],
  [['horse', :purple] , ['neigh', {r: 240, g: 32, b: 32}], [true, 'mammal', :green], '13a1fb'],
  [['cow', :gray]     , ['moo', :blue]                   , [true, 'mammal', :green], 0x12ff02]
]

window('Animal sounds', 400, 200) {
  horizontal_box {
    table {
      text_color_column('Animal')
      text_color_column('Sound')
      checkbox_text_color_column('Description')
      background_color_column('Mammal')

      cell_rows data
    }
  }
}.show
