# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

window('Basic Image', 96, 96) {
  area {
    on_draw do |area_draw_params|
      image {
        file File.expand_path('../icons/glimmer.png', __dir__)
        width 96
        height 96
      }
    end
  }
}.show
