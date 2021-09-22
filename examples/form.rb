# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('Form') { |w|
  margined true
  
  vertical_box {
    form {
      @first_name_entry = entry {
        label 'First Name' # label property is available when control is nested under form
      }
      
      @last_name_entry = entry {
        label 'Last Name' # label property is available when control is nested under form
      }
    }
    
    button('Display Name') {
      on_clicked do
        msg_box(w, 'Name', "#{@first_name_entry.text} #{@last_name_entry.text}")
      end
    }
  }
}.show
