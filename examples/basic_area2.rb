require 'glimmer-dsl-libui'

include Glimmer

window('Basic Area', 400, 400) {
  margined true
  
  area {
    on_draw do |area_draw_params|
      rectangle(0, 0, 400, 400) { # dynamic implicit path shape, added semi-declaratively inside on_draw block
        fill r: 102, g: 102, b: 204, a: 1.0
      }
    end
  }
}.show
