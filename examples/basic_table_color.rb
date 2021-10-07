# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

data = [
  [['cat', :red], ['meow', :blue], {r: 255, g: 120, b: 0, a: 0.5}],
  [['dog', :yellow], ['woof', {r: 240, g: 32, b: 32}], :skyblue],
  [['chicken', :beige], ['cock-a-doodle-doo', :blue], {r: 5, g: 120, b: 110}],
  [['horse', :purple], ['neigh', {r: 240, g: 32, b: 32}], '13a1fb'],
  [['cow', :gray], ['moo', :blue], 0x12ff02]
]

window('Animal sounds', 300, 200) {
  horizontal_box {
    table {
      text_color_column('Animal')
      text_color_column('Description')
      background_color_column('Mammal')

      cell_rows data
    }
  }
}.show
