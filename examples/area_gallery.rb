require 'glimmer-dsl-libui'

include Glimmer

window('Area Gallery', 400, 400) {
  area {
    path { # declarative stable path
      square(0, 0, 100)
      square(100, 100, 400)
      
      fill r: 102, g: 102, b: 204
    }
    path { # declarative stable path
      rectangle(0, 100, 100, 400)
      rectangle(100, 0, 400, 100)
      
      fill r: 204, g: 102, b: 204
    }
    path { # declarative stable path
      figure(100, 100) {
        line(100, 400)
        line(400, 100)
        line(400, 400)

        closed true
      }

      fill r: 202, g: 102, b: 104, a: 0.5
      stroke r: 0, g: 0, b: 0
    }
    path { # declarative stable path
      figure(0, 0) {
        bezier(200, 100, 100, 200, 400, 100)
        bezier(300, 100, 100, 300, 100, 400)
        bezier(100, 300, 300, 100, 400, 400)

        closed true
      }

      fill r: 202, g: 102, b: 204, a: 0.5
      stroke thickness: 2, r: 0, g: 0, b: 0
    }
    path { # declarative stable path
      arc(200, 200, 90, 0, 360, false)

      fill r: 202, g: 102, b: 204, a: 0.5
      stroke thickness: 2, r: 0, g: 0, b: 0
    }
  }
}.show
