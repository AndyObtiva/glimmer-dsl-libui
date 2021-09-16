# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('Notepad', 500, 300, 1) {
  on_closing do
    puts 'Bye Bye'
  end
  
  vertical_box {
    non_wrapping_multiline_entry
  }
}.show
