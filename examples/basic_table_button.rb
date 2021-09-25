# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

data = [
  %w[cat meow delete],
  %w[dog woof delete],
  %w[chicken cock-a-doodle-doo delete],
  %w[hourse neigh delete],
  %w[cow moo delete]
]

window('Animal sounds', 300, 200) {
  horizontal_box {
    table {
      text_column('Animal')
      text_column('Description')
      button_column('Action') {
        on_clicked do |row|
          puts "Clicked for row: #{row}"
#           data.delete(row) # TODO
        end
      }

      cell_rows data
    }
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
