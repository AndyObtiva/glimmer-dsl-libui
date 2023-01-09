# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

data = [
  ['cat', 'meow', true],
  ['dog', 'woof', true],
  ['chicken', 'cock-a-doodle-doo', false],
  ['horse', 'neigh', true],
  ['cow', 'moo', true]
]

window('Animal sounds', 400, 200) {
  horizontal_box {
    table {
      text_column('Animal')
      text_column('Description')
      checkbox_column('Mammal') {
        editable true
      }

      cell_rows data
      
      on_changed do |row, type, row_data| # fires on all changes (even ones happening through data array)
        puts "Row #{row} #{type}: #{row_data}"
        $stdout.flush
      end
      
      on_edited do |row, row_data| # only fires on direct table editing
        puts "Row #{row} edited: #{row_data}"
        $stdout.flush
      end
    }
  }
}.show
