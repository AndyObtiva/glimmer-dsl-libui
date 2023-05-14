require 'glimmer-dsl-libui'

include Glimmer

window('Area Gallery', 400, 400) {
  area {
    path { # declarative stable path (explicit path syntax for multiple shapes sharing attributes)
      square(0, 0, 100)
      square(100, 100, 400)
      
      fill r: 102, g: 102, b: 204
    }
    
    path { # declarative stable path (explicit path syntax for multiple shapes sharing attributes)
      rectangle(0, 100, 100, 400)
      rectangle(100, 0, 400, 100)
      
      # linear gradient (has x0, y0, x1, y1, and stops)
      fill x0: 10, y0: 10, x1: 350, y1: 350, stops: [{pos: 0.25, r: 204, g: 102, b: 204}, {pos: 0.75, r: 102, g: 102, b: 204}]
    }
    
    polygon(100, 100, 100, 400, 400, 100, 400, 400) { # declarative stable path (implicit path syntax for a single shape nested directly under area)
      fill r: 202, g: 102, b: 104, a: 0.5
      stroke r: 0, g: 0, b: 0
    }
    
    polybezier(0, 0,
               200, 100, 100, 200, 400, 100,
               300, 100, 100, 300, 100, 400,
               100, 300, 300, 100, 400, 400) { # declarative stable path (implicit path syntax for a single shape nested directly under area)
      fill r: 202, g: 102, b: 204, a: 0.5
      stroke r: 0, g: 0, b: 0, thickness: 2, dashes: [50, 10, 10, 10], dash_phase: -50.0
    }
    
    polyline(100, 100, 400, 100, 100, 400, 400, 400, 0, 0) { # declarative stable path (implicit path syntax for a single shape nested directly under area)
      stroke r: 0, g: 0, b: 0, thickness: 2
    }
    
    arc(404, 216, 190, 90, 90, false) { # declarative stable path (implicit path syntax for a single shape nested directly under area)
      # radial gradient (has an outer_radius in addition to x0, y0, x1, y1, and stops)
      fill outer_radius: 90, x0: 0, y0: 0, x1: 500, y1: 500, stops: [{pos: 0.25, r: 102, g: 102, b: 204, a: 0.5}, {pos: 0.75, r: 204, g: 102, b: 204}]
      stroke r: 0, g: 0, b: 0, thickness: 2, dashes: [50, 10, 10, 10], dash_phase: -50.0
    }
    
    circle(200, 200, 90) { # declarative stable path (implicit path syntax for a single shape nested directly under area)
      fill r: 202, g: 102, b: 204, a: 0.5
      stroke r: 0, g: 0, b: 0, thickness: 2
    }
    
    text(161, 40, 100) { # declarative stable text
      string('Area Gallery') {
        font family: 'Arial', size: (OS.mac? ? 14 : 11)
        color :black
      }
    }
    
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
      # As a smart default, key events are assumed to be handled if you add a key event listener,
      # but you can return false to indicate a key event is not handled to allow it
      # to propagate to other operating system key handlers, like the Mac quit menu item,
      # which expects a COMMAND+Q shortcut usually.
      # Otherwise, if you return false in all key event handlers for a specific key combo,
      # the Mac beeps (makes a "fonk" sound), which is normal behavior on the Mac.
      case area_key_event
      in modifiers: [:command], key: 'q'
        false if OS.mac? # allow to propagate to Mac quit menu item
      else
        # true # no return value (nil) or any return value other than false or 0 means true (event handled)
      end
    end
    
    on_key_up do |area_key_event|
      puts 'key up'
      # As a smart default, key events are assumed to be handled if you add a key event listener,
      # but you can return false to indicate a key event is not handled to allow it
      # to propagate to other operating system key handlers, like the Mac quit menu item,
      # which expects a COMMAND+Q shortcut usually.
      # Otherwise, if you return false in all key event handlers for a specific key combo,
      # the Mac beeps (makes a "fonk" sound), which is normal behavior on the Mac.
      case area_key_event
      in modifiers: [:command], key: 'q'
        false if OS.mac? # allow to propagate to Mac quit menu item
      else
        # true # no return value (nil) or any return value other than false or 0 means true (event handled)
      end
    end
    
    on_key_down do |area_key_event|
      puts 'key down'
      # As a smart default, key events are assumed to be handled if you add a key event listener,
      # but you can return false to indicate a key event is not handled to allow it
      # to propagate to other operating system key handlers, like the Mac quit menu item,
      # which expects a COMMAND+Q shortcut usually.
      # Otherwise, if you return false in all key event handlers for a specific key combo,
      # the Mac beeps (makes a "fonk" sound), which is normal behavior on the Mac.
      case area_key_event
      in modifiers: [:command], key: 'q'
        false if OS.mac? # allow to propagate to Mac quit menu item
      else
        # true # no return value (nil) or any return value other than false or 0 means true (event handled)
      end
    end
  }
}.show
