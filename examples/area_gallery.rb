require 'glimmer-dsl-libui'

include Glimmer

window('Area Gallery', 400, 400) {
  vertical_box {
    area {
      path { # declarative stable path
        rectangle(0, 0, 100, 100)
        rectangle(100, 100, 400, 400)
        
        fill r: 102, g: 102, b: 204
      }
      path { # declarative stable path
        figure(100, 100) {
          line(100, 400)
          line(400, 100)
          line(400, 400)
          
          closed true
        }
        
        fill r: 202, g: 102, b: 104, a: 0.5
        stroke thickness: 1, r: 0, g: 0, b: 0
      }
    }
  }
}.show
