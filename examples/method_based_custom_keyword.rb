require 'glimmer-dsl-libui'
require 'facets'

include Glimmer

Address = Struct.new(:street, :p_o_box, :city, :state, :zip_code)

def form_field(model, property)
  property = property.to_s
  entry { |e|
    label property.underscore.split('_').map(&:capitalize).join(' ')
    text model.send(property).to_s

    on_changed do
      model.send("#{property}=", e.text)
    end
  }
end

def address_form(address)
  form {
    form_field(address, :street)
    form_field(address, :p_o_box)
    form_field(address, :city)
    form_field(address, :state)
    form_field(address, :zip_code)
  }
end

def label_pair(model, attribute, value)
  name_label = nil
  value_label = nil
  horizontal_box {
    name_label = label(attribute.to_s.underscore.split('_').map(&:capitalize).join(' '))
    value_label = label(value.to_s)
  }
  observe(model, attribute) do
    value_label.text = model.send(attribute)
  end
end

def address(address)
  vertical_box {
    address.each_pair do |attribute, value|
      label_pair(address, attribute, value)
    end
  }
end

address1 = Address.new('123 Main St', '23923', 'Denver', 'Colorado', '80014')
address2 = Address.new('2038 Park Ave', '83272', 'Boston', 'Massachusetts', '02101')

window('Method-Based Custom Keyword') {
  margined true
  
  horizontal_box {
    vertical_box {
      label('Address 1') {
        stretchy false
      }
      
      address_form(address1)
      
      horizontal_separator {
        stretchy false
      }
      
      label('Address 1 (Saved)') {
        stretchy false
      }
      
      address(address1)
    }
    
    vertical_separator {
      stretchy false
    }
    
    vertical_box {
      label('Address 2') {
        stretchy false
      }
      
      address_form(address2)
      
      horizontal_separator {
        stretchy false
      }
      
      label('Address 2 (Saved)') {
        stretchy false
      }
      
      address(address2)
    }
  }
}.show
