# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('Basic Entry', 300, 50, 1) { |w|
  horizontal_box {
    e = entry {
      stretchy 1
    
      on_changed do
        puts e.text
        $stdout.flush # For Windows
      end
    }
    
    button('Button') {
      stretchy 0
      
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
