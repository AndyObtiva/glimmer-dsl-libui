# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('Basic Image', 512, 512) {
  area {
    on_draw do |area_draw_params|
      image(File.expand_path('../icons/glimmer.png', __dir__), 96, 96)
    end
  }
}.show
