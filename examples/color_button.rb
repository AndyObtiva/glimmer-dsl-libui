# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('color button', 230) {
  color_button { |cb|
    on_changed do
      rgba = cb.color
      p rgba
    end
  }
}.show
