require 'glimmer-dsl-libui'

class Login
  include Glimmer
  
  attr_accessor :username, :password
  attr_reader :logged_in
  
  def logged_in=(value)
    @logged_in = value
    notify_observers(:logged_out) # manually notify observers of logged_out upon logged_in changes; this method comes automatically from enhancement as Glimmer::DataBinding::ObservableModel via data-binding
  end
  
  def logged_out
    !logged_in
  end
  
  def launch
    window('Login') {
      margined true
      
      vertical_box {
        form {
          entry {
            label 'Username:'
            text <=> [self, :username]
            enabled <= [self, :logged_out]
          }
          
          password_entry {
            label 'Password:'
            text <=> [self, :password]
            enabled <= [self, :logged_out]
          }
        }
        
        horizontal_box {
          button('Login') {
            enabled <= [self, :logged_out]
            
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
