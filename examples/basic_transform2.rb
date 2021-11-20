require 'glimmer-dsl-libui'

include Glimmer

window('Basic Transform', 350, 350) {
  area {
    path {
      square(0, 0, 350)
      
      fill r: 255, g: 255, b: 0
    }
    40.times do |n|
      path {
        square(0, 0, 100)
        
        fill r: [255 - n*5, 0].max, g: [n*5, 255].min, b: 0, a: 0.5
        stroke :black, thickness: 2
        
        transform {
          unless OS.windows?
            skew 0.15, 0.15
            translate 50, 50
          end
          rotate 100, 100, -9 * n
          scale 1.1, 1.1
          if OS.windows?
            skew 0.15, 0.15
            translate 50, 50
          end
        }
      }
    end
  }
}.show
