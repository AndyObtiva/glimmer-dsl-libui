require 'glimmer-dsl-libui'

class ColorButton
  include Glimmer
  
  attr_accessor :selected_color
  
  def initialize
    @selected_color = :blue
  end
  
  def launch
    window('color button', 240) {
      color_button {
        color <=> [self, :selected_color, after_write: ->(color) {p color}]
      }
    }.show
  end
end

ColorButton.new.launch
