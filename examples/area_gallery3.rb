require 'glimmer-dsl-libui'

include Glimmer

window('Area Gallery', 400, 400) {
  area {
    on_draw do |area_draw_params|
      polygon(100, 100, 100, 400, 400, 100, 400, 400) { # dynamic path, added semi-declaratively inside on_draw block
        fill r: 202, g: 102, b: 104, a: 0.5
        stroke r: 0, g: 0, b: 0
      }
      
      polybezier(0, 0,
                 200, 100, 100, 200, 400, 100,
                 300, 100, 100, 300, 100, 400,
                 100, 300, 300, 100, 400, 400) { # dynamic path, added semi-declaratively inside on_draw block
        fill r: 202, g: 102, b: 204, a: 0.5
        stroke r: 0, g: 0, b: 0, thickness: 2, dashes: [50, 10, 10, 10], dash_phase: -50.0
      }
      
      polyline(100, 100, 400, 100, 100, 400, 400, 400, 0, 0) { # dynamic path, added semi-declaratively inside on_draw block
        stroke r: 0, g: 0, b: 0, thickness: 2
      }
      
      arc(404, 216, 190, 90, 90, false) { # dynamic path, added semi-declaratively inside on_draw block
        # radial gradient (has an outer_radius in addition to x0, y0, x1, y1, and stops)
        fill outer_radius: 90, x0: 0, y0: 0, x1: 500, y1: 500, stops: [{pos: 0.25, r: 102, g: 102, b: 204, a: 0.5}, {pos: 0.75, r: 204, g: 102, b: 204}]
        stroke r: 0, g: 0, b: 0, thickness: 2, dashes: [50, 10, 10, 10], dash_phase: -50.0
      }
      
      circle(200, 200, 90) { # dynamic path, added semi-declaratively inside on_draw block
        fill r: 202, g: 102, b: 204, a: 0.5
        stroke r: 0, g: 0, b: 0, thickness: 2
      }
      
      path { # dynamic path, added semi-declaratively inside on_draw block
        square(0, 0, 100)
        square(100, 100, 400)
        
        fill r: 102, g: 102, b: 204
      }
      
      path { # dynamic path, added semi-declaratively inside on_draw block
        rectangle(0, 100, 100, 400)
        rectangle(100, 0, 400, 100)
        
        # linear gradient (has x0, y0, x1, y1, and stops)
        fill x0: 10, y0: 10, x1: 350, y1: 350, stops: [{pos: 0.25, r: 204, g: 102, b: 204}, {pos: 0.75, r: 102, g: 102, b: 204}]
      }
      
      text(161, 40, 100) { # dynamic text added semi-declaratively inside on_draw block
        string('Area Gallery') {
          font family: 'Arial', size: (OS.mac? ? 14 : 11)
          color :black
        }
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
