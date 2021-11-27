# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('Login') {
  margined true
  
  vertical_box {
    form {
      @username_entry = entry {
        label 'Username:'
      }
      
      @password_entry = password_entry {
        label 'Password:'
      }
    }
    
    horizontal_box {
      @login_button = button('Login') {
        on_clicked do
          @username_entry.enabled = false
          @password_entry.enabled = false
          @login_button.enabled = false
          @logout_button.enabled = true
        end
      }
      
      @logout_button = button('Logout') {
        enabled false
        
        on_clicked do
          @username_entry.text = ''
          @password_entry.text = ''
          @username_entry.enabled = true
          @password_entry.enabled = true
          @login_button.enabled = true
          @logout_button.enabled = false
        end
      }
    }
  }
}.show
