# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

data = [
  ['cat', 'meow', {r: 255, g: 120, b: 0, a: 0.5}],
  ['dog', 'woof', :skyblue],
  ['chicken', 'cock-a-doodle-doo', {r: 5, g: 120, b: 110}],
  ['horse', 'neigh', '13a1fb'],
  ['cow', 'moo', 0x12ff02]
]

window('Animal sounds', 300, 200) {
  horizontal_box {
    table {
      text_column('Animal')
      text_column('Description')
      background_color_column('Mammal')

      cell_rows data
    }
  }
}.show
