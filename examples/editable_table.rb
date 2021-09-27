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
    }
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
