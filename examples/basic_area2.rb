require 'glimmer-dsl-libui'

include Glimmer

window('Basic Area', 400, 400) {
  margined true
  
  vertical_box {
    area {
      on_draw do |area_draw_params|
        path { # a dynamic path is added semi-declaratively inside on_draw block
          rectangle(0, 0, 400, 400)
          
          fill r: 102, g: 102, b: 204, a: 1.0
        }
      end
    }
  }
}.show
