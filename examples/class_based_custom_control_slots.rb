require 'glimmer-dsl-libui'
require 'facets'

Address = Struct.new(:street, :p_o_box, :city, :state, :zip_code)

class FormField
  include Glimmer::LibUI::CustomControl
  
  options :model, :attribute
  
  body {
    entry { |e|
      label attribute.to_s.underscore.split('_').map(&:capitalize).join(' ')
      text <=> [model, attribute]
    }
  }
end

class AddressForm
  include Glimmer::LibUI::CustomControl
  
  option :address
  
  body {
    vertical_box {
      vertical_box(slot: :header) {
        stretchy false
      }
      form {
        form_field(model: address, attribute: :street)
        form_field(model: address, attribute: :p_o_box)
        form_field(model: address, attribute: :city)
        form_field(model: address, attribute: :state)
        form_field(model: address, attribute: :zip_code)
      }
      vertical_box(slot: :footer) {
        stretchy false
      }
    }
  }
end

class LabelPair
  include Glimmer::LibUI::CustomControl
  
  options :model, :attribute, :value
  
  body {
    horizontal_box {
      label(attribute.to_s.underscore.split('_').map(&:capitalize).join(' '))
      label(value.to_s) {
        text <= [model, attribute]
      }
    }
  }
end

class AddressView
  include Glimmer::LibUI::CustomControl
  
  options :address
  
  body {
    vertical_box {
      vertical_box(slot: :header) {
        stretchy false
      }
      address.each_pair do |attribute, value|
        label_pair(model: address, attribute: attribute, value: value)
      end
    }
  }
end

class ClassBasedCustomControlSlots
  include Glimmer::LibUI::Application # alias: Glimmer::LibUI::CustomWindow
  
  before_body do
    @address1 = Address.new('123 Main St', '23923', 'Denver', 'Colorado', '80014')
    @address2 = Address.new('2038 Park Ave', '83272', 'Boston', 'Massachusetts', '02101')
  end
  
  body {
    window('Class-Based Custom Control Slots') {
      margined true
      
      horizontal_box {
        vertical_box {
          address_form(address: @address1) {
            header {
              label('Shipping Address') {
                stretchy false
              }
            }
            footer {
              label('Shipping address is used for mailing purchases') {
                stretchy false
              }
            }
          }
          
          horizontal_separator {
            stretchy false
          }
          
          address_view(address: @address1) {
            header {
              label('Shipping Address (Saved)') {
                stretchy false
              }
            }
          }
        }
        
        vertical_separator {
          stretchy false
        }
        
        vertical_box {
          address_form(address: @address2) {
            header {
              label('Billing Address') {
                stretchy false
              }
            }
            footer {
              label('Billing address is used for online payments') {
                stretchy false
              }
            }
          }
          
          horizontal_separator {
            stretchy false
          }
                    
          address_view(address: @address2) {
            header {
              label('Billing Address (Saved)') {
                stretchy false
              }
            }
          }
        }
      }
    }
  }
end

ClassBasedCustomControlSlots.launch
