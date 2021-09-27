# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

data = [
  ['cat', 'meow', [true, 'mammal']],
  ['dog', 'woof', [true, 'mammal']],
  ['chicken', 'cock-a-doodle-doo', [false, 'mammal']],
  ['horse', 'neigh', [true, 'mammal']],
  ['cow', 'moo', [true, 'mammal']]
]

window('Animal sounds', 400, 200) {
  horizontal_box {
    table {
      text_column('Animal')
      text_column('Sound')
      checkbox_text_column('Description')

      cell_rows data
    }
  }
}.show
