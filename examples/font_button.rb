# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

menu('File') {
  menu_item('Destroy') {
    on_clicked do
      @f.destroy
    end
  }
}

window('hello world', 300, 200) {
  @f = font_button { |fb|
    on_changed do
      font_descriptor = fb.font
      p font_descriptor
    end
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
