# frozen_string_literal: true

require 'glimmer-dsl-libui'

class FontButton
  include Glimmer
  
  attr_accessor :font_descriptor
  
  def launch
    window('hello world', 300, 200) {
      font_button {
        font <=> [self, :font_descriptor, after_write: -> { p font_descriptor }]
      }
      
      on_closing do
        puts 'Bye Bye'
      end
    }.show
  end
end

FontButton.new.launch
