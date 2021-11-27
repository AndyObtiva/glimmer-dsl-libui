# frozen_string_literal: true

require 'glimmer-dsl-libui'

class Login
  include Glimmer
  
  attr_accessor :username, :password, :logged_in
  
  def launch
    window('Login') {
      margined true
      
      vertical_box {
        form {
          entry {
            label 'Username:'
            text <=> [self, :username]
            enabled <= [self, :logged_in, on_read: :!]
          }
          
          password_entry {
            label 'Password:'
            text <=> [self, :password]
            enabled <= [self, :logged_in, on_read: :!]
          }
        }
        
        horizontal_box {
          button('Login') {
            enabled <= [self, :logged_in, on_read: :!]
            
            on_clicked do
              self.logged_in = true
            end
          }
          
          button('Logout') {
            enabled <= [self, :logged_in]
            
            on_clicked do
              self.logged_in = false
              self.username = ''
              self.password = ''
            end
          }
        }
      }
    }.show
  end
end

Login.new.launch
