# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

data = [
  %w[cat meow delete],
  %w[dog woof delete],
  %w[chicken cock-a-doodle-doo delete],
  %w[horse neigh delete],
  %w[cow moo delete]
]

window('Animal sounds', 400, 200) {
  table {
    text_column('Animal')
    text_column('Description')
    button_column('Action') {
      on_clicked do |row|
        data.delete_at(row) # automatically deletes actual table row due to implicit data-binding
      end
    }

    cell_rows data # implicit data-binding
    
    on_changed do |row, type, row_data|
      puts "Row #{row} #{type}: #{row_data}"
      $stdout.flush
    end
  }
}.show
