# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('color_button') {
  vertical_box {
  c = color_button { |cb|
    on_changed do
      rgba = cb.color
      p rgba
    end
  }
  button('destroy') {
    on_clicked do
      c.destroy
    end
  }
  }
}.show
