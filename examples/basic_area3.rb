require 'glimmer-dsl-libui'

include Glimmer

window('Basic Area', 400, 400) {
  margined true
  
  area {
    path { # stable path, added declaratively
      rectangle(0, 0, 400, 400)
      
      fill r: 102, g: 102, b: 204, a: 1.0
    }
  }
}.show
