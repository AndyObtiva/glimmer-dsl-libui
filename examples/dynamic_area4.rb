require 'glimmer-dsl-libui'

include Glimmer

window('Dynamic Area', 240, 600) {
  margined true
  
  vertical_box {
    label('Rectangle Properties') {
      stretchy false
    }
    
    form {
      stretchy false
      
      @x_spinbox = spinbox(0, 1000) {
        label 'x'
        value 25
        
        on_changed do
          @rectangle.x = @x_spinbox.value # updating properties automatically triggers area.queue_redraw_all
        end
      }
      
      @y_spinbox = spinbox(0, 1000) {
        label 'y'
        value 25
        
        on_changed do
          @rectangle.y = @y_spinbox.value # updating properties automatically triggers area.queue_redraw_all
        end
      }
      
      @width_spinbox = spinbox(0, 1000) {
        label 'width'
        value 150
        
        on_changed do
          @rectangle.width = @width_spinbox.value # updating properties automatically triggers area.queue_redraw_all
        end
      }
      
      @height_spinbox = spinbox(0, 1000) {
        label 'height'
        value 150
        
        on_changed do
          @rectangle.height = @height_spinbox.value # updating properties automatically triggers area.queue_redraw_all
        end
      }
      
      @red_spinbox = spinbox(0, 255) {
        label 'red'
        value 102
        
        on_changed do
          @rectangle.fill[:r] = @red_spinbox.value # updating hash properties automatically triggers area.queue_redraw_all
        end
      }
      
      @green_spinbox = spinbox(0, 255) {
        label 'green'
        value 102
        
        on_changed do
          @rectangle.fill[:g] = @green_spinbox.value # updating hash properties automatically triggers area.queue_redraw_all
        end
      }
      
      @blue_spinbox = spinbox(0, 255) {
        label 'blue'
        value 204
        
        on_changed do
          @rectangle.fill[:b] = @blue_spinbox.value # updating hash properties automatically triggers area.queue_redraw_all
        end
      }
      
      @alpha_spinbox = spinbox(0, 100) {
        label 'alpha'
        value 100
        
        on_changed do
          @rectangle.fill[:a] = @alpha_spinbox.value / 100.0 # updating hash properties automatically triggers area.queue_redraw_all
        end
      }
    }
    
    area {
      @rectangle = rectangle(@x_spinbox.value, @y_spinbox.value, @width_spinbox.value, @height_spinbox.value) { # stable implicit path shape
        fill r: @red_spinbox.value, g: @green_spinbox.value, b: @blue_spinbox.value, a: @alpha_spinbox.value / 100.0
      }
    }
  }
}.show
