# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('Form') { |w|
  margined true
  
  vertical_box {
    form {
      @first_name_entry = entry {
        # stretchy true # Smart default option for appending to form
        label 'First Name'
      }
      
      @last_name_entry = entry {
        # stretchy true # Smart default option for appending to form
        label 'Last Name'
      }
    }
    
    button('Display Name') {
      on_clicked do
        msg_box(w, 'Name', "#{@first_name_entry.text} #{@last_name_entry.text}")
      end
    }
  }
}.show
