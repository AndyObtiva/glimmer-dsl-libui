require 'glimmer-dsl-libui'

include Glimmer

window('Area Gallery', 400, 400) {
  area {
    on_draw do |area_draw_params|
      path { # a dynamic path is added semi-declaratively inside on_draw block
        square {
          x 0
          y 0
          length 100
        }
        square {
          x 100
          y 100
          length 400
        }
        
        fill r: 102, g: 102, b: 204
      }
      path { # a dynamic path is added semi-declaratively inside on_draw block
        rectangle {
          x 0
          y 100
          width 100
          height 400
        }
        rectangle {
          x 100
          y 0
          width 400
          height 100
        }
        
        fill r: 204, g: 102, b: 204
      }
      path { # a dynamic path is added semi-declaratively inside on_draw block
        figure {
          x 100
          y 100
          
          line {
            x 100
            y 400
          }
          line {
            x 400
            y 100
          }
          line {
            x 400
            y 400
          }

          closed true
        }

        fill r: 202, g: 102, b: 104, a: 0.5
        stroke r: 0, g: 0, b: 0
      }
      path { # a dynamic path is added semi-declaratively inside on_draw block
        figure {
          x 0
          y 0
          
          bezier {
            c1_x 200
            c1_y 100
            c2_x 100
            c2_y 200
            end_x 400
            end_y 100
          }
          bezier {
            c1_x 300
            c1_y 100
            c2_x 100
            c2_y 300
            end_x 100
            end_y 400
          }
          bezier {
            c1_x 100
            c1_y 300
            c2_x 300
            c2_y 100
            end_x 400
            end_y 400
          }

          closed true
        }

        fill r: 202, g: 102, b: 204, a: 0.5
        stroke r: 0, g: 0, b: 0, thickness: 2, dashes: [50, 10, 10, 10], dash_phase: -50.0
      }
      path { # a dynamic path is added semi-declaratively inside on_draw block
        circle {
          x_center 200
          y_center 200
          radius 90
        }
  
        fill r: 202, g: 102, b: 204, a: 0.5
        stroke r: 0, g: 0, b: 0, thickness: 2
      }
      path { # a dynamic path is added semi-declaratively inside on_draw block
        arc {
          x_center 400
          y_center 220
          radius 180
          start_angle 90
          sweep 90
          is_negative false
        }
  
        fill r: 204, g: 102, b: 204, a: 0.5
        stroke r: 0, g: 0, b: 0, thickness: 2, dashes: [50, 10, 10, 10], dash_phase: -50.0
      }
    end
    
    on_mouse_event do |area_mouse_event|
      p area_mouse_event
    end
    
    on_mouse_moved do |area_mouse_event|
      puts 'moved'
    end
    
    on_mouse_down do |area_mouse_event|
      puts 'mouse down'
    end
    
    on_mouse_up do |area_mouse_event|
      puts 'mouse up'
    end
    
    on_mouse_drag_started do |area_mouse_event|
      puts 'drag started'
    end
    
    on_mouse_dragged do |area_mouse_event|
      puts 'dragged'
    end
    
    on_mouse_dropped do |area_mouse_event|
      puts 'dropped'
    end
    
    on_mouse_entered do
      puts 'entered'
    end
    
    on_mouse_exited do
      puts 'exited'
    end
    
    on_key_event do |area_key_event|
      p area_key_event
    end
    
    on_key_up do |area_key_event|
      puts 'key up'
    end
    
    on_key_down do |area_key_event|
      puts 'key down'
    end
  }
}.show
