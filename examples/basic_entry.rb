# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('Basic Entry', 300, 50) { |w|
  horizontal_box {
    e = entry {
      # stretchy true # Smart default option for appending to horizontal_box
    
      on_changed do
        puts e.text
        $stdout.flush # For Windows
      end
    }
    
    button('Button') {
      stretchy false
      
      on_clicked do
        text = e.text
        msg_box(w, 'You entered', text)
      end
    }
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
