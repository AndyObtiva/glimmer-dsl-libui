# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('hello world', 300, 200) { |w|
  button('Button') {
    on_clicked do
      msg_box(w, 'Information', 'You clicked the button')
    end
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
