require 'glimmer-dsl-libui'

include Glimmer

window('Basic Area', 400, 400) {
  margined true
  
  vertical_box {
    area {
#       path { # a stable path is added declaratively
#         rectangle(0, 0, 400, 400)
#         fill r: 0.4, g: 0.4, b: 0.8, a: 1.0
#       }
    }
  }
}.show
