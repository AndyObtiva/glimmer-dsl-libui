# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

data = [
  ['cat', 'meow', false, false],
  ['dog', 'woof', false, false],
  ['chicken', 'cock-a-doodle-doo', true, false],
  ['hourse', 'neigh', false, false],
  ['cow', 'moo', false, false]
]

window('Animal sounds', 500, 200) {
  vertical_box {
    table {
      text_column('Animal')
      text_column('Description')
      checkbox_column('Bird')
      checkbox_column('Selected (Editable)') {
        editable true
      }

      cell_rows data # implicit data-binding
    }
    button('Delete Selected') {
      stretchy false
      
      on_clicked do
        data.each_with_index.to_a.reverse do |data_row, row|
          data.delete_at(row) if data_row[3]
        end
      end
    }
  }
}.show
