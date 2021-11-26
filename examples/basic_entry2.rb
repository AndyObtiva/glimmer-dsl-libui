# frozen_string_literal: true

require 'glimmer-dsl-libui'

class BasicEntry
  include Glimmer
  
  attr_accessor :entry_text
  
  def launch
    window('Basic Entry', 300, 50) {
      horizontal_box {
        e = entry {
          # stretchy true # Smart default option for appending to horizontal_box
          text <=> [self, :entry_text]
        }
        
        button('Button') {
          stretchy false # stretchy property is available when control is nested under horizontal_box
          
          on_clicked do
            msg_box('You entered', entry_text)
          end
        }
      }
      
      on_closing do
        puts 'Bye Bye'
      end
    }.show
  end
end

BasicEntry.new.launch
