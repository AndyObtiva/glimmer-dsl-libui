# frozen_string_literal: true

require 'glimmer-dsl-libui'

class Form
  include Glimmer
  
  attr_accessor :first_name, :last_name, :phone, :email
  
  def launch
    window('Form') {
      margined true
      
      vertical_box {
        form {
          entry {
            label 'First Name' # label property is available when control is nested under form
            text <=> [self, :first_name] # bidirectional data-binding of entry text property to self first_name attribute
          }
          
          entry {
            label 'Last Name' # label property is available when control is nested under form
            text <=> [self, :last_name]
          }
          
          entry {
            label 'Phone' # label property is available when control is nested under form
            text <=> [self, :phone]
          }
          
          entry {
            label 'Email' # label property is available when control is nested under form
            text <=> [self, :email]
          }
        }
        
        button('Display Info') {
          stretchy false
          
          on_clicked do
            msg_box('Info', "#{first_name} #{last_name} has phone #{phone} and email #{email}")
          end
        }
      }
    }.show
  end
end

Form.new.launch
