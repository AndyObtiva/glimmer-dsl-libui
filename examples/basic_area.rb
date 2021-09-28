require 'glimmer-dsl-libui'

include Glimmer

window('Basic Area', 400, 400) {
  margined true
  
  vertical_box {
    area {
      path { # a stable path is added declaratively
        figure(50, 50) {
          rectangle(0, 0, 400, 400)
          closed true
        }
        
        fill r: 102, g: 102, b: 204, a: 1.0
      }
    }
  }
}.show
