require 'glimmer-dsl-libui'

class User
  ALL_ATTRIBUTES = [:first_name, :last_name, :email, :street, :city, :state, :zip_code, :country]
  
  attr_accessor :customizable_attributes, *ALL_ATTRIBUTES
  
  def initialize
    # allow customizing all attributes by default
    self.customizable_attributes = ALL_ATTRIBUTES.dup
  end
  
  def select_customizable_attribute(attribute, selected)
    if selected
      customizable_attributes.push(attribute)
    else
      customizable_attributes.delete(attribute)
    end
    customizable_attributes.sort_by! {|attribute| User::ALL_ATTRIBUTES.index(attribute)}
  end
end

class DynamicForm
  include Glimmer::LibUI::Application
  
  before_body do
    @user = User.new
  end
  
  body {
    window('Dynamic Form') {
      margined true
      
      vertical_box {
        horizontal_box {
          User::ALL_ATTRIBUTES.each do |attribute|
            checkbox(attribute.to_s) {
              checked <=> [@user, :customizable_attributes,
                           on_read: -> (attributes) { @user.customizable_attributes.include?(attribute) },
                           on_write: -> (checked_value) { @user.select_customizable_attribute(attribute, checked_value) }
                          ]
            }
          end
        }
        
        form {
          stretchy false
          
          # Control content data-binding allows dynamically changing content based on changes in a model attribute
          content(@user, :customizable_attributes) {
            @user.customizable_attributes.each do |attribute|
              entry {
                label attribute.to_s.split('_').map(&:capitalize).join(' ')
                text <=> [@user, attribute]
              }
            end
          }
        }

        button('Summarize') {
          on_clicked do
            summary = @user.customizable_attributes.map { |attribute| @user.send(attribute) }.join(', ')
            msg_box('Summary', summary)
          end
        }
      }
    }
  }
end

DynamicForm.launch
