# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

data = [
  ['task 1', 0],
  ['task 2', 15],
  ['task 3', 100],
  ['task 4', 75],
  ['task 5', -1],
]

window('Task Progress', 300, 200) {
  horizontal_box {
    table {
      text_column('Task')
      progress_bar_column('Progress')

      cell_rows data
    }
  }
}.show
