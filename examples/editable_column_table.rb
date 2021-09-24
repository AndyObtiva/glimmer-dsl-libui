# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

data = [
  %w[cat calm meow],
  %w[dog loyal woof],
  %w[chicken bird cock-a-doodle-doo],
  %w[hourse fast neigh],
  %w[cow slow moo]
]

window('Editable column animal sounds', 400, 200) {
  horizontal_box {
    table {
      text_column('Animal')
      text_column('Description')
      text_column('Sound (Editable)') {
        editable true
      }

      cell_rows data
    }
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
