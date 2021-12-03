require 'glimmer-dsl-libui'

include Glimmer

window('Basic Image', 96, 96) {
  area {
    # image is not a real LibUI control. It is built in Glimmer as a custom control that renders
    # tiny pixels/lines as rectangle paths. As such, it does not have good performance, but can
    # be used in exceptional circumstances where an image control is really needed.
    #
    # Furthermore, adding image directly under area is even slower due to taking up more memory for every
    # image pixel rendered. Check basic_image4.rb for a faster alternative using on_draw manually.
    #
    # It is recommended to pass width/height args to shrink image and achieve faster performance.
    image {
      file File.expand_path('../icons/glimmer.png', __dir__)
#       x 0 # default
#       y 0 # default
#       width 96 # gets calculated from height while preserving original aspect ratio of 512x512
      height 96
    }
  }
}.show
