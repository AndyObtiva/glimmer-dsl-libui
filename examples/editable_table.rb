# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

data = [
  %w[cat meow],
  %w[dog woof],
  %w[chicken cock-a-doodle-doo],
  %w[horse neigh],
  %w[cow moo]
]

window('Editable animal sounds', 300, 200) {
  horizontal_box {
    table {
      text_column('Animal')
      text_column('Description')

      cell_rows data
      editable true
      
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
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
