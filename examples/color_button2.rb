require 'glimmer-dsl-libui'

include Glimmer

window('color button', 240) {
  color_button { |cb|
    color :blue
    
    on_changed do
      rgba = cb.color
      p rgba
    end
  }
}.show
