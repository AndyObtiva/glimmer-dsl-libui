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
  table {
    text_column('Animal')
    text_column('Sound')
    checkbox_text_column('Description') {
      editable true
    }

    cell_rows data
    
    on_changed do |row, type, row_data| # fires on all changes (even ones happening through data array)
      puts "Row #{row} #{type}: #{row_data.map(&:to_s)}"
      $stdout.flush
    end
    
    on_edited do |row, row_data| # only fires on direct table editing
      puts "Row #{row} edited: #{row_data.map(&:to_s)}"
      $stdout.flush
    end
  }
}.show
