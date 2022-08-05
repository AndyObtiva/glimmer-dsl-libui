# Glimmer DSL for LibUI Advanced Examples

- [Glimmer DSL for LibUI Advanced Examples](#glimmer-dsl-for-libui-advanced-examples)
  - [Area Gallery](#area-gallery)
  - [Button Counter](#button-counter)
  - [Color The Circles](#color-the-circles)
  - [Control Gallery](#control-gallery)
  - [CPU Percentage](#cpu-percentage)
  - [Custom Draw Text](#custom-draw-text)
  - [Dynamic Area](#dynamic-area)
  - [Editable Column Table](#editable-column-table)
  - [Editable Table](#editable-table)
  - [Form Table](#form-table)
  - [Paginated Refined Table](#paginated-refined-table)
  - [Grid](#grid)
  - [Histogram](#histogram)
  - [Login](#login)
  - [Method-Based Custom Controls](#method-based-custom-controls)
  - [Class-Based Custom Controls](#class-based-custom-controls)
  - [Area-Based Custom Controls](#area-based-custom-controls)
  - [Midi Player](#midi-player)
  - [Snake](#snake)
  - [Tetris](#tetris)
  - [Tic Tac Toe](#tic-tac-toe)
  - [Timer](#timer)
  - [Shape Coloring](#shape-coloring)
      
## Area Gallery

[examples/area_gallery.rb](/examples/area_gallery.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/area_gallery.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/area_gallery'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-area-gallery.png](/images/glimmer-dsl-libui-mac-area-gallery.png) | ![glimmer-dsl-libui-windows-area-gallery.png](/images/glimmer-dsl-libui-windows-area-gallery.png) | ![glimmer-dsl-libui-linux-area-gallery.png](/images/glimmer-dsl-libui-linux-area-gallery.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
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
    end
    
    on_key_up do |area_key_event|
      puts 'key up'
    end
    
    on_key_down do |area_key_event|
      puts 'key down'
    end
  }
}.show
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (setting shape properties instead of arguments):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Area Gallery', 400, 400) {
  area {
    path { # declarative stable path with explicit attributes (explicit path syntax for multiple shapes sharing attributes)
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
    
    path { # declarative stable path with explicit attributes (explicit path syntax for multiple shapes sharing attributes)
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
      
      # linear gradient (has x0, y0, x1, y1, and stops)
      fill x0: 10, y0: 10, x1: 350, y1: 350, stops: [{pos: 0.25, r: 204, g: 102, b: 204}, {pos: 0.75, r: 102, g: 102, b: 204}]
    }
    
    figure { # declarative stable path with explicit attributes (implicit path syntax for a single shape nested directly under area)
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

      closed true # polygon figure is closed (last point forms a line with first point)
      fill r: 202, g: 102, b: 104, a: 0.5
      stroke r: 0, g: 0, b: 0
    }
    
    figure { # declarative stable path with explicit attributes (implicit path syntax for a single shape nested directly under area)
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
      
      fill r: 202, g: 102, b: 204, a: 0.5
      stroke r: 0, g: 0, b: 0, thickness: 2, dashes: [50, 10, 10, 10], dash_phase: -50.0
    }
    
    figure { # declarative stable path with explicit attributes (implicit path syntax for a single shape nested directly under area)
      x 100
      y 100
      
      line {
        x 400
        y 100
      }
      
      line {
        x 100
        y 400
      }
      
      line {
        x 400
        y 400
      }
      
      line {
        x 0
        y 0
      }
      
      stroke r: 0, g: 0, b: 0, thickness: 2
    }
    
    arc { # declarative stable path with explicit attributes (implicit path syntax for a single shape nested directly under area)
      x_center 404
      y_center 216
      radius 190
      start_angle 90
      sweep 90
      is_negative false
      # radial gradient (has an outer_radius in addition to x0, y0, x1, y1, and stops)
      fill outer_radius: 90, x0: 0, y0: 0, x1: 500, y1: 500, stops: [{pos: 0.25, r: 102, g: 102, b: 204, a: 0.5}, {pos: 0.75, r: 204, g: 102, b: 204}]
      stroke r: 0, g: 0, b: 0, thickness: 2, dashes: [50, 10, 10, 10], dash_phase: -50.0
    }
    
    circle { # declarative stable path with explicit attributes (implicit path syntax for a single shape nested directly under area)
      x_center 200
      y_center 200
      radius 90
      fill r: 202, g: 102, b: 204, a: 0.5
      stroke r: 0, g: 0, b: 0, thickness: 2
    }
    
    text { # declarative stable text with explicit attributes
      x 161
      y 40
      width 100
      
      string {
        font family: 'Arial', size: (OS.mac? ? 14 : 11)
        color :black
        
        'Area Gallery'
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
    end
    
    on_key_up do |area_key_event|
      puts 'key up'
    end
    
    on_key_down do |area_key_event|
      puts 'key down'
    end
  }
}.show
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 3 (semi-declarative `on_draw` dynamic `path` approach):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Area Gallery', 400, 400) {
  area {
    on_draw do |area_draw_params|
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
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 4 (setting shape properties instead of arguments with semi-declarative `on_draw` dynamic `path` approach):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Area Gallery', 400, 400) {
  area {
    on_draw do |area_draw_params|
      path { # dynamic path, added semi-declaratively inside on_draw block
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
      
      path { # dynamic path, added semi-declaratively inside on_draw block
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
        
        # linear gradient (has x0, y0, x1, y1, and stops)
        fill x0: 10, y0: 10, x1: 350, y1: 350, stops: [{pos: 0.25, r: 204, g: 102, b: 204}, {pos: 0.75, r: 102, g: 102, b: 204}]
      }
      
      figure { # dynamic path, added semi-declaratively inside on_draw block
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
  
        closed true # polygon figure is closed (last point forms a line with first point)
        fill r: 202, g: 102, b: 104, a: 0.5
        stroke r: 0, g: 0, b: 0
      }
      
      figure { # dynamic path, added semi-declaratively inside on_draw block
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
        
        fill r: 202, g: 102, b: 204, a: 0.5
        stroke r: 0, g: 0, b: 0, thickness: 2, dashes: [50, 10, 10, 10], dash_phase: -50.0
      }
      
      figure { # dynamic path, added semi-declaratively inside on_draw block
        x 100
        y 100
        
        line {
          x 400
          y 100
        }
        
        line {
          x 100
          y 400
        }
        
        line {
          x 400
          y 400
        }
        
        line {
          x 0
          y 0
        }
        
        stroke r: 0, g: 0, b: 0, thickness: 2
      }
      
      arc { # dynamic path, added semi-declaratively inside on_draw block
        x_center 404
        y_center 216
        radius 190
        start_angle 90
        sweep 90
        is_negative false
        # radial gradient (has an outer_radius in addition to x0, y0, x1, y1, and stops)
        fill outer_radius: 90, x0: 0, y0: 0, x1: 500, y1: 500, stops: [{pos: 0.25, r: 102, g: 102, b: 204, a: 0.5}, {pos: 0.75, r: 204, g: 102, b: 204}]
        stroke r: 0, g: 0, b: 0, thickness: 2, dashes: [50, 10, 10, 10], dash_phase: -50.0
      }
      
      circle { # dynamic path, added semi-declaratively inside on_draw block
        x_center 200
        y_center 200
        radius 90
        fill r: 202, g: 102, b: 204, a: 0.5
        stroke r: 0, g: 0, b: 0, thickness: 2
      }
      
      text { # dynamic path, added semi-declaratively inside on_draw block
        x 161
        y 40
        width 100
        
        string {
          font family: 'Arial', size: (OS.mac? ? 14 : 11)
          color :black
          
          'Area Gallery'
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
```

## Button Counter

[examples/button_counter.rb](/examples/button_counter.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/button_counter.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/button_counter'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-button-counter.png](/images/glimmer-dsl-libui-mac-button-counter.png) | ![glimmer-dsl-libui-windows-button-counter.png](/images/glimmer-dsl-libui-windows-button-counter.png) | ![glimmer-dsl-libui-linux-button-counter.png](/images/glimmer-dsl-libui-linux-button-counter.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

class ButtonCounter
  include Glimmer

  attr_accessor :count

  def initialize
    @count = 0
  end

  def launch
    window('Hello, Button!') {
      button {
        # data-bind button text to self count, converting to string on read.
        text <= [self, :count, on_read: ->(count) {"Count: #{count}"}]
        
        on_clicked do
          self.count += 1
        end
      }
    }.show
  end
end

ButtonCounter.new.launch
```

## Color The Circles

[examples/color_the_circles.rb](/examples/color_the_circles.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/color_the_circles.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/color_the_circles'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-color-the-circles.png](/images/glimmer-dsl-libui-mac-color-the-circles.png) ![glimmer-dsl-libui-mac-color-the-circles-lost.png](/images/glimmer-dsl-libui-mac-color-the-circles-lost.png) ![glimmer-dsl-libui-mac-color-the-circles-won.png](/images/glimmer-dsl-libui-mac-color-the-circles-won.png) | ![glimmer-dsl-libui-windows-color-the-circles.png](/images/glimmer-dsl-libui-windows-color-the-circles.png) ![glimmer-dsl-libui-windows-color-the-circles-lost.png](/images/glimmer-dsl-libui-windows-color-the-circles-lost.png) ![glimmer-dsl-libui-windows-color-the-circles-won.png](/images/glimmer-dsl-libui-windows-color-the-circles-won.png) | ![glimmer-dsl-libui-linux-color-the-circles.png](/images/glimmer-dsl-libui-linux-color-the-circles.png) ![glimmer-dsl-libui-linux-color-the-circles-lost.png](/images/glimmer-dsl-libui-linux-color-the-circles-lost.png) ![glimmer-dsl-libui-linux-color-the-circles-won.png](/images/glimmer-dsl-libui-linux-color-the-circles-won.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

class ColorTheCircles
  include Glimmer
  
  WINDOW_WIDTH = 800
  WINDOW_HEIGHT = 600
  SHAPE_MIN_SIZE = 15
  SHAPE_MAX_SIZE = 75
  MARGIN_WIDTH = 55
  MARGIN_HEIGHT = 155
  TIME_MAX_EASY = 4
  TIME_MAX_MEDIUM = 3
  TIME_MAX_HARD = 2
  TIME_MAX_INSANE = 1
  
  attr_accessor :score
  
  def initialize
    @circles_data = []
    @score = 0
    @time_max = TIME_MAX_HARD
    @game_over = false
    register_observers
    setup_circle_factory
  end
  
  def register_observers
    # observe automatically enhances self to become Glimmer::DataBinding::ObservableModel and notify observer block of score attribute changes
    observe(self, :score) do |new_score|
      Glimmer::LibUI.queue_main do
        @score_label.text = new_score.to_s
        if new_score == -20
          @game_over = true
          msg_box('You Lost!', 'Sorry! Your score reached -20')
          restart_game
        elsif new_score == 0
          @game_over = true
          msg_box('You Won!', 'Congratulations! Your score reached 0')
          restart_game
        end
      end
    end
  end
  
  def setup_circle_factory
    consumer = Proc.new do
      unless @game_over
        if @circles_data.empty?
          # start with 3 circles to make more challenging
          add_circle until @circles_data.size > 3
        else
          add_circle
        end
      end
      delay = rand * @time_max
      Glimmer::LibUI.timer(delay, repeat: false, &consumer)
    end
    Glimmer::LibUI.queue_main(&consumer)
  end
  
  def add_circle
    circle_x = rand * (WINDOW_WIDTH - MARGIN_WIDTH - SHAPE_MAX_SIZE) + SHAPE_MAX_SIZE
    circle_y = rand * (WINDOW_HEIGHT - MARGIN_HEIGHT - SHAPE_MAX_SIZE) + SHAPE_MAX_SIZE
    circle_size = rand * (SHAPE_MAX_SIZE - SHAPE_MIN_SIZE) + SHAPE_MIN_SIZE
    stroke_color = Glimmer::LibUI.x11_colors.sample
    @circles_data << {
      args: [circle_x, circle_y, circle_size],
      fill: nil,
      stroke: stroke_color
    }
    @area.queue_redraw_all
    self.score -= 1 # notifies score observers automatically of change
  end
  
  def restart_game
    @score = 0 # update variable directly to avoid notifying observers
    @circles_data.clear
    @game_over = false
  end
  
  def color_circle(x, y)
    clicked_circle_data = @circles_data.find do |circle_data|
      circle_data[:fill].nil? && circle_data[:circle]&.contain?(x, y)
    end
    if clicked_circle_data
      clicked_circle_data[:fill] = clicked_circle_data[:stroke]
      push_colored_circle_behind_uncolored_circles(clicked_circle_data)
      @area.queue_redraw_all
      self.score += 1 # notifies score observers automatically of change
    end
  end
  
  def push_colored_circle_behind_uncolored_circles(colored_circle_data)
    removed_colored_circle_data = @circles_data.delete(colored_circle_data)
    last_colored_circle_data = @circles_data.select {|cd| cd[:fill]}.last
    last_colored_circle_data_index = @circles_data.index(last_colored_circle_data) || -1
    @circles_data.insert(last_colored_circle_data_index + 1, removed_colored_circle_data)
  end

  def launch
    menu('Actions') {
      menu_item('Restart') {
        on_clicked do
          restart_game
        end
      }
      
      quit_menu_item
    }
    
    menu('Difficulty') {
      radio_menu_item('Easy') {
        on_clicked do
          @time_max = TIME_MAX_EASY
        end
      }
      
      radio_menu_item('Medium') {
        on_clicked do
          @time_max = TIME_MAX_MEDIUM
        end
      }
      
      radio_menu_item('Hard') {
        checked true
        
        on_clicked do
          @time_max = TIME_MAX_HARD
        end
      }
      
      radio_menu_item('Insane') {
        on_clicked do
          @time_max = TIME_MAX_INSANE
        end
      }
    }
    
    menu('Help') {
      menu_item('Instructions') {
        on_clicked do
          msg_box('Instructions', "Score goes down as circles are added.\nIf it reaches -20, you lose!\n\nClick circles to color and score!\nOnce score reaches 0, you win!\n\nBeware of concealed light-colored circles!\nThey are revealed once darker circles intersect them.\n\nThere are four levels of difficulty.\nChange via difficulty menu if the game gets too tough.")
        end
      }
    }
    
    window('Color The Circles', WINDOW_WIDTH, WINDOW_HEIGHT) {
      margined true
      
      grid {
        button('Restart') {
          left 0
          top 0
          halign :center
          
          on_clicked do
            restart_game
          end
        }
        
        label('Score goes down as circles are added. If it reaches -20, you lose!') {
          left 0
          top 1
          halign :center
        }
        
        label('Click circles to color and score! Once score reaches 0, you win!') {
          left 0
          top 2
          halign :center
        }
        
        horizontal_box {
          left 0
          top 3
          halign :center
          
          label('Score:') {
            stretchy false
          }
          
          @score_label = label(@score.to_s) {
            stretchy false
          }
        }
        
        @area = area {
          left 0
          top 4
          hexpand true
          vexpand true
          halign :fill
          valign :fill

          on_draw do |area_draw_params|
            path {
              rectangle(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)

              fill :white
            }

            @circles_data.each do |circle_data|
              circle_data[:circle] = circle(*circle_data[:args]) {
                fill circle_data[:fill]
                stroke circle_data[:stroke]
              }
            end
          end

          on_mouse_down do |area_mouse_event|
            color_circle(area_mouse_event[:x], area_mouse_event[:y])
          end
        }
      }
    }.show
  end
end

ColorTheCircles.new.launch
```

## Control Gallery

[examples/control_gallery.rb](/examples/control_gallery.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/control_gallery.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/control_gallery'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-control-gallery.png](/images/glimmer-dsl-libui-mac-control-gallery.png) | ![glimmer-dsl-libui-windows-control-gallery.png](/images/glimmer-dsl-libui-windows-control-gallery.png) | ![glimmer-dsl-libui-linux-control-gallery.png](/images/glimmer-dsl-libui-linux-control-gallery.png)

[LibUI](https://github.com/kojix2/LibUI) Original Version:

```ruby
require 'libui'
UI = LibUI

UI.init

should_quit = proc do
  puts 'Bye Bye'
  UI.control_destroy(MAIN_WINDOW)
  UI.quit
  0
end

# File menu
menu = UI.new_menu('File')
open_menu_item = UI.menu_append_item(menu, 'Open')
UI.menu_item_on_clicked(open_menu_item) do
  pt = UI.open_file(MAIN_WINDOW)
  puts pt unless pt.null?
end
save_menu_item = UI.menu_append_item(menu, 'Save')
UI.menu_item_on_clicked(save_menu_item) do
  pt = UI.save_file(MAIN_WINDOW)
  puts pt unless pt.null?
end

UI.menu_append_quit_item(menu)
UI.on_should_quit(should_quit)

# Edit menu
edit_menu = UI.new_menu('Edit')
UI.menu_append_check_item(edit_menu, 'Checkable Item_')
UI.menu_append_separator(edit_menu)
disabled_item = UI.menu_append_item(edit_menu, 'Disabled Item_')
UI.menu_item_disable(disabled_item)

preferences = UI.menu_append_preferences_item(menu)

# Help menu
help_menu = UI.new_menu('Help')
UI.menu_append_item(help_menu, 'Help')
UI.menu_append_about_item(help_menu)

# Main Window
MAIN_WINDOW = UI.new_window('Control Gallery', 600, 500, 1)
UI.window_set_margined(MAIN_WINDOW, 1)
UI.window_on_closing(MAIN_WINDOW, should_quit)

vbox = UI.new_vertical_box
UI.window_set_child(MAIN_WINDOW, vbox)
hbox = UI.new_horizontal_box
UI.box_set_padded(vbox, 1)
UI.box_set_padded(hbox, 1)

UI.box_append(vbox, hbox, 1)

# Group - Basic Controls
group = UI.new_group('Basic Controls')
UI.group_set_margined(group, 1)
UI.box_append(hbox, group, 1) # OSX bug?

inner = UI.new_vertical_box
UI.box_set_padded(inner, 1)
UI.group_set_child(group, inner)

# Button
button = UI.new_button('Button')
UI.button_on_clicked(button) do
  UI.msg_box(MAIN_WINDOW, 'Information', 'You clicked the button')
end
UI.box_append(inner, button, 0)

# Checkbox
checkbox = UI.new_checkbox('Checkbox')
UI.checkbox_on_toggled(checkbox) do |ptr|
  checked = UI.checkbox_checked(ptr) == 1
  UI.window_set_title(MAIN_WINDOW, "Checkbox is #{checked}")
  UI.checkbox_set_text(ptr, "I am the checkbox (#{checked})")
end
UI.box_append(inner, checkbox, 0)

# Label
UI.box_append(inner, UI.new_label('Label'), 0)

# Separator
UI.box_append(inner, UI.new_horizontal_separator, 0)

# Date Picker
UI.box_append(inner, UI.new_date_picker, 0)

# Time Picker
UI.box_append(inner, UI.new_time_picker, 0)

# Date Time Picker
UI.box_append(inner, UI.new_date_time_picker, 0)

# Font Button
UI.box_append(inner, UI.new_font_button, 0)

# Color Button
UI.box_append(inner, UI.new_color_button, 0)

inner2 = UI.new_vertical_box
UI.box_set_padded(inner2, 1)
UI.box_append(hbox, inner2, 1)

# Group - Numbers
group = UI.new_group('Numbers')
UI.group_set_margined(group, 1)
UI.box_append(inner2, group, 0)

inner = UI.new_vertical_box
UI.box_set_padded(inner, 1)
UI.group_set_child(group, inner)

# Spinbox
spinbox = UI.new_spinbox(0, 100)
UI.spinbox_set_value(spinbox, 42)
UI.spinbox_on_changed(spinbox) do |ptr|
  puts "New Spinbox value: #{UI.spinbox_value(ptr)}"
end
UI.box_append(inner, spinbox, 0)

# Slider
slider = UI.new_slider(0, 100)
UI.box_append(inner, slider, 0)

# Progressbar
progressbar = UI.new_progress_bar
UI.box_append(inner, progressbar, 0)

UI.slider_on_changed(slider) do |ptr|
  v = UI.slider_value(ptr)
  puts "New Slider value: #{v}"
  UI.progress_bar_set_value(progressbar, v)
end

# Group - Lists
group = UI.new_group('Lists')
UI.group_set_margined(group, 1)
UI.box_append(inner2, group, 0)

inner = UI.new_vertical_box
UI.box_set_padded(inner, 1)
UI.group_set_child(group, inner)

# Combobox
cbox = UI.new_combobox
UI.combobox_append(cbox, 'combobox Item 1')
UI.combobox_append(cbox, 'combobox Item 2')
UI.combobox_append(cbox, 'combobox Item 3')
UI.box_append(inner, cbox, 0)
UI.combobox_on_selected(cbox) do |ptr|
  puts "New combobox selection: #{UI.combobox_selected(ptr)}"
end

# Editable Combobox
ebox = UI.new_editable_combobox
UI.editable_combobox_append(ebox, 'Editable Item 1')
UI.editable_combobox_append(ebox, 'Editable Item 2')
UI.editable_combobox_append(ebox, 'Editable Item 3')
UI.box_append(inner, ebox, 0)

# Radio Buttons
rb = UI.new_radio_buttons
UI.radio_buttons_append(rb, 'Radio Button 1')
UI.radio_buttons_append(rb, 'Radio Button 2')
UI.radio_buttons_append(rb, 'Radio Button 3')
UI.box_append(inner, rb, 1)

# Tab
tab = UI.new_tab
hbox1 = UI.new_horizontal_box
hbox2 = UI.new_horizontal_box
UI.tab_append(tab, 'Page 1', hbox1)
UI.tab_append(tab, 'Page 2', hbox2)
UI.tab_append(tab, 'Page 3', UI.new_horizontal_box)
UI.box_append(inner2, tab, 1)

# Text Entry
text_entry = UI.new_entry
UI.entry_set_text text_entry, 'Please enter your feelings'
UI.entry_on_changed(text_entry) do |ptr|
  puts "Current textbox data: '#{UI.entry_text(ptr)}'"
end
UI.box_append(hbox1, text_entry, 1)

UI.control_show(MAIN_WINDOW)

UI.main
UI.quit
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

menu('File') {
  menu_item('Open') {
    on_clicked do
      file = open_file
      puts file unless file.nil?
    end
  }

  menu_item('Save') {
    on_clicked do
      file = save_file
      puts file unless file.nil?
    end
  }
  
  quit_menu_item {
    on_clicked do
      puts 'Bye Bye'
    end
  }
  
  preferences_menu_item # Can optionally contain an on_clicked listener
}

menu('Edit') {
  check_menu_item('Checkable Item_')
  separator_menu_item
  menu_item('Disabled Item_') {
    enabled false
  }
}

menu('Help') {
  menu_item('Help')
  
  about_menu_item # Can optionally contain an on_clicked listener
}

MAIN_WINDOW = window('Control Gallery', 600, 500) {
  margined true
  
  on_closing do
    puts 'Bye Bye'
  end
  
  vertical_box {
    horizontal_box {
      group('Basic Controls') {
        vertical_box {
          button('Button') {
            stretchy false

            on_clicked do
              msg_box('Information', 'You clicked the button')
            end
          }

          checkbox('Checkbox') {
            stretchy false

            on_toggled do |c|
              checked = c.checked?
              MAIN_WINDOW.title = "Checkbox is #{checked}"
              c.text = "I am the checkbox (#{checked})"
            end
          }

          label('Label') { stretchy false }

          horizontal_separator { stretchy false }

          date_picker { stretchy false }

          time_picker { stretchy false }

          date_time_picker { stretchy false }

          font_button { stretchy false }

          color_button { stretchy false }
        }
      }

      vertical_box {
        group('Numbers') {
          stretchy false

          vertical_box {
            spinbox(0, 100) {
              stretchy false
              value 42

              on_changed do |s|
                puts "New Spinbox value: #{s.value}"
              end
            }

            slider(0, 100) {
              stretchy false

              on_changed do |s|
                v = s.value
                puts "New Slider value: #{v}"
                @progress_bar.value = v
              end
            }

            @progress_bar = progress_bar { stretchy false }
          }
        }

        group('Lists') {
          stretchy false

          vertical_box {
            combobox {
              stretchy false
              items 'combobox Item 1', 'combobox Item 2', 'combobox Item 3' # also accepts a single array argument

              on_selected do |c|
                puts "New combobox selection: #{c.selected}"
              end
            }

            editable_combobox {
              stretchy false
              items 'Editable Item 1', 'Editable Item 2', 'Editable Item 3' # also accepts a single array argument
            }

            radio_buttons {
              items 'Radio Button 1', 'Radio Button 2', 'Radio Button 3' # also accepts a single array argument
            }
          }
        }

        tab {
          tab_item('Page 1') {
            horizontal_box {
              entry {
                text 'Please enter your feelings'

                on_changed do |e|
                  puts "Current textbox data: '#{e.text}'"
                end
              }
            }
          }
          
          tab_item('Page 2') {
            horizontal_box
          }
          
          tab_item('Page 3') {
            horizontal_box
          }
        }
      }
    }
  }
}

MAIN_WINDOW.show
```

## CPU Percentage

This example shows CPU usage percentage second by second.

Note that it is highly dependent on low-level OS terminal commands, so if anything changes in their output formatting, the code could break. Please report any issues you might encounter.

[examples/cpu_percentage.rb](/examples/cpu_percentage.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/cpu_percentage.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/cpu_percentage'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-cpu-percentage.png](/images/glimmer-dsl-libui-mac-cpu-percentage.png) | ![glimmer-dsl-libui-windows-cpu-percentage.png](/images/glimmer-dsl-libui-windows-cpu-percentage.png) | ![glimmer-dsl-libui-linux-cpu-percentage.png](/images/glimmer-dsl-libui-linux-cpu-percentage.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'
require 'bigdecimal'

include Glimmer

data = [
  ['CPU', '0%', 0],
]

Glimmer::LibUI.timer(1) do
  cpu_percentage_value = nil
  if OS.windows?
    cpu_percentage_raw_value = `wmic cpu get loadpercentage`
    cpu_percentage_value = cpu_percentage_raw_value.split("\n").map(&:strip).find {|l| l.match(/^\d+$/)}.to_i
  elsif OS.mac?
    cpu_percentage_value = `ps -A -o %cpu | awk '{s+=$1} END {print s}'`.to_i
  elsif OS.linux?
    stats = `top -n 1`
    idle_percentage = stats.split("\n")[2].match(/ni,.* (.*) .*id/)[1]
    cpu_percentage_value = (BigDecimal(100) - BigDecimal(idle_percentage)).to_i
  end
  data[0][1] = "#{cpu_percentage_value}%"
  data[0][2] = cpu_percentage_value
end

window('CPU Percentage', 400, 50) {
  vertical_box {
    table {
      text_column('Name')
      text_column('Value')
      progress_bar_column('Percentage')

      cell_rows data # implicit data-binding
    }
  }
}.show
```

## Custom Draw Text

[examples/custom_draw_text.rb](/examples/custom_draw_text.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/custom_draw_text.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/custom_draw_text'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-custom-draw-text.png](/images/glimmer-dsl-libui-mac-custom-draw-text.png) ![glimmer-dsl-libui-mac-custom-draw-text-changed.png](/images/glimmer-dsl-libui-mac-custom-draw-text-changed.png) | ![glimmer-dsl-libui-windows-custom-draw-text.png](/images/glimmer-dsl-libui-windows-custom-draw-text.png) ![glimmer-dsl-libui-windows-custom-draw-text-changed.png](/images/glimmer-dsl-libui-windows-custom-draw-text-changed.png) | ![glimmer-dsl-libui-linux-custom-draw-text.png](/images/glimmer-dsl-libui-linux-custom-draw-text.png) ![glimmer-dsl-libui-linux-custom-draw-text-changed.png](/images/glimmer-dsl-libui-linux-custom-draw-text-changed.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

# Michael Ende (1929-1995)
# The Neverending Story is a fantasy novel by German writer Michael Ende,
# The English version, translated by Ralph Manheim, was published in 1983.
class CustomDrawText
  include Glimmer
  
  def launch
    window('Michael Ende (1929-1995) The Neverending Story', 600, 500) {
      margined true
      
      vertical_box {
        form {
          stretchy false
          
          font_button { |fb|
            label 'Font'
            
            on_changed do
              @string.font = fb.font
            end
          }

          color_button { |cb|
            label 'Color'
            
            on_changed do
              @string.color = cb.color
            end
          }

          unless OS.windows?
            color_button { |cb|
              label 'Background'
              
              on_changed do
                @string.background = cb.color
              end
            }
          end

          combobox { |c|
            label 'Underline'
            items Glimmer::LibUI.enum_symbols(:underline).map(&:to_s).map {|word| word.split('_').map(&:capitalize).join(' ')}
            selected 'None'
            
            on_selected do
              @string.underline = c.selected_item.underscore
            end
          }

          combobox { |c|
            label 'Underline Built-In Color'
            items Glimmer::LibUI.enum_symbols(:underline_color).map(&:to_s).map(&:capitalize)
            selected 'Custom'
            
            on_selected do
              @underline_custom_color_button.enabled = c.selected_item == 'Custom'
              if c.selected_item == 'Custom'
                @string.underline_color = @underline_custom_color_button.color
              else
                @string.underline_color = c.selected_item.underscore
                @underline_custom_color_button.color = :black
              end
            end
          }

          @underline_custom_color_button = color_button {
            label 'Underline Custom Color'
            
            on_changed do
              @string.underline_color = @underline_custom_color_button.color
            end
          }
        }
        
        area {
          text { # default arguments for x, y, and width are (0, 0, area_draw_params[:area_width] - 2*x)
            # align :left # default alignment
            
            @string = string {
              '  At last Ygramul sensed that something was coming toward ' \
              'her. With the speed of lightning, she turned about, confronting ' \
              'Atreyu with an enormous steel-blue face. Her single eye had a ' \
              'vertical pupil, which stared at Atreyu with inconceivable malignancy. ' \
              "\n\n" \
              '  A cry of fear escaped Bastian. ' \
              "\n\n" \
              '  A cry of terror passed through the ravine and echoed from ' \
              'side to side. Ygramul turned her eye to left and right, to see if ' \
              'someone else had arrived, for that sound could not have been ' \
              'made by the boy who stood there as though paralyzed with ' \
              'horror. ' \
              "\n\n" \
              '  Could she have heard my cry? Bastion wondered in alarm. ' \
              "But that's not possible. " \
              "\n\n" \
              '  And then Atreyu heard Ygramuls voice. It was very high ' \
              'and slightly hoarse, not at all the right kind of voice for that ' \
              'enormous face. Her lips did not move as she spoke. It was the ' \
              'buzzing of a great swarm of hornets that shaped itself into ' \
              'words. ' \
              "\n\n"
            }
          }
        }
      }
    }.show
  end
end

CustomDrawText.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2:

```ruby
require 'glimmer-dsl-libui'

# Michael Ende (1929-1995)
# The Neverending Story is a fantasy novel by German writer Michael Ende,
# The English version, translated by Ralph Manheim, was published in 1983.
class CustomDrawText
  include Glimmer

  def launch
    window('Michael Ende (1929-1995) The Neverending Story', 600, 500) {
      margined true

      vertical_box {
        form {
          stretchy false

          font_button { |fb|
            label 'Font'

            on_changed do
              @font = fb.font
              @area.queue_redraw_all
            end
          }

          color_button { |cb|
            label 'Color'

            on_changed do
              @color = cb.color
              @area.queue_redraw_all
            end
          }

          unless OS.windows?
            color_button { |cb|
              label 'Background'

              on_changed do
                @background = cb.color
                @area.queue_redraw_all
              end
            }
          end

          combobox { |c|
            label 'Underline'
            items Glimmer::LibUI.enum_symbols(:underline).map(&:to_s).map {|word| word.split('_').map(&:capitalize).join(' ')}
            selected 'None'

            on_selected do
              @underline = c.selected_item.underscore
              @area.queue_redraw_all
            end
          }

          combobox { |c|
            label 'Underline Built-In Color'
            items Glimmer::LibUI.enum_symbols(:underline_color).map(&:to_s).map(&:capitalize)
            selected 'Custom'

            on_selected do
              @underline_custom_color_button.enabled = c.selected_item == 'Custom'
              if c.selected_item == 'Custom'
                @underline_color = @underline_custom_color_button.color
              else
                @underline_color = c.selected_item.underscore
                @underline_custom_color_button.color = :black
              end
              @area.queue_redraw_all
            end
          }

          @underline_custom_color_button = color_button {
            label 'Underline Custom Color'

            on_changed do
              @underline_color = @underline_custom_color_button.color
              @area.queue_redraw_all
            end
          }
        }

        @area = area {
          on_draw do |area_draw_params|
            text { # default arguments for x, y, and width are (0, 0, area_draw_params[:area_width] - 2*x)
              # align :left # default alignment

              string {
                font @font
                color @color
                background @background
                underline @underline
                underline_color @underline_color

                '  At last Ygramul sensed that something was coming toward ' \
                'her. With the speed of lightning, she turned about, confronting ' \
                'Atreyu with an enormous steel-blue face. Her single eye had a ' \
                'vertical pupil, which stared at Atreyu with inconceivable malignancy. ' \
                "\n\n" \
                '  A cry of fear escaped Bastian. ' \
                "\n\n" \
                '  A cry of terror passed through the ravine and echoed from ' \
                'side to side. Ygramul turned her eye to left and right, to see if ' \
                'someone else had arrived, for that sound could not have been ' \
                'made by the boy who stood there as though paralyzed with ' \
                'horror. ' \
                "\n\n" \
                '  Could she have heard my cry? Bastion wondered in alarm. ' \
                "But that's not possible. " \
                "\n\n" \
                '  And then Atreyu heard Ygramuls voice. It was very high ' \
                'and slightly hoarse, not at all the right kind of voice for that ' \
                'enormous face. Her lips did not move as she spoke. It was the ' \
                'buzzing of a great swarm of hornets that shaped itself into ' \
                'words. ' \
                "\n\n"
              }
            }
          end
        }
      }
    }.show
  end
end

CustomDrawText.new.launch
```

## Dynamic Area

[examples/dynamic_area.rb](/examples/dynamic_area.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/dynamic_area.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/dynamic_area'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-dynamic-area.png](/images/glimmer-dsl-libui-mac-dynamic-area.png) ![glimmer-dsl-libui-mac-dynamic-area-updated.png](/images/glimmer-dsl-libui-mac-dynamic-area-updated.png) | ![glimmer-dsl-libui-windows-dynamic-area.png](/images/glimmer-dsl-libui-windows-dynamic-area.png) ![glimmer-dsl-libui-windows-dynamic-area-updated.png](/images/glimmer-dsl-libui-windows-dynamic-area-updated.png) | ![glimmer-dsl-libui-linux-dynamic-area.png](/images/glimmer-dsl-libui-linux-dynamic-area.png) ![glimmer-dsl-libui-linux-dynamic-area-updated.png](/images/glimmer-dsl-libui-linux-dynamic-area-updated.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class DynamicArea
  include Glimmer
  
  attr_accessor :rectangle_x, :rectangle_y, :rectangle_width, :rectangle_height, :rectangle_red, :rectangle_green, :rectangle_blue, :rectangle_alpha
  
  def initialize
    @rectangle_x = 25
    @rectangle_y = 25
    @rectangle_width = 150
    @rectangle_height = 150
    @rectangle_red = 102
    @rectangle_green = 102
    @rectangle_blue = 204
    @rectangle_alpha = 100
  end
  
  def launch
    window('Dynamic Area', 240, 600) {
      margined true
      
      vertical_box {
        label('Rectangle Properties') {
          stretchy false
        }
        
        form {
          stretchy false
          
          spinbox(0, 1000) {
            label 'x'
            value <=> [self, :rectangle_x, after_write: -> {@area.queue_redraw_all}]
          }
          
          spinbox(0, 1000) {
            label 'y'
            value <=> [self, :rectangle_y, after_write: -> {@area.queue_redraw_all}]
          }
          
          spinbox(0, 1000) {
            label 'width'
            value <=> [self, :rectangle_width, after_write: -> {@area.queue_redraw_all}]
          }
          
          spinbox(0, 1000) {
            label 'height'
            value <=> [self, :rectangle_height, after_write: -> {@area.queue_redraw_all}]
          }
          
          spinbox(0, 255) {
            label 'red'
            value <=> [self, :rectangle_red, after_write: -> {@area.queue_redraw_all}]
          }
          
          spinbox(0, 255) {
            label 'green'
            value <=> [self, :rectangle_green, after_write: -> {@area.queue_redraw_all}]
          }
          
          spinbox(0, 255) {
            label 'blue'
            value <=> [self, :rectangle_blue, after_write: -> {@area.queue_redraw_all}]
          }
          
          spinbox(0, 100) {
            label 'alpha'
            value <=> [self, :rectangle_alpha, after_write: -> {@area.queue_redraw_all}]
          }
        }
        
        @area = area {
          on_draw do |area_draw_params|
            rectangle(rectangle_x, rectangle_y, rectangle_width, rectangle_height) { # a dynamic path is added semi-declaratively inside on_draw block
              fill r: rectangle_red, g: rectangle_green, b: rectangle_blue, a: rectangle_alpha / 100.0
            }
          end
        }
      }
    }.show
  end
end

DynamicArea.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby
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
          @area.queue_redraw_all
        end
      }
      
      @y_spinbox = spinbox(0, 1000) {
        label 'y'
        value 25
        
        on_changed do
          @area.queue_redraw_all
        end
      }
      
      @width_spinbox = spinbox(0, 1000) {
        label 'width'
        value 150
        
        on_changed do
          @area.queue_redraw_all
        end
      }
      
      @height_spinbox = spinbox(0, 1000) {
        label 'height'
        value 150
        
        on_changed do
          @area.queue_redraw_all
        end
      }
      
      @red_spinbox = spinbox(0, 255) {
        label 'red'
        value 102
        
        on_changed do
          @area.queue_redraw_all
        end
      }
      
      @green_spinbox = spinbox(0, 255) {
        label 'green'
        value 102
        
        on_changed do
          @area.queue_redraw_all
        end
      }
      
      @blue_spinbox = spinbox(0, 255) {
        label 'blue'
        value 204
        
        on_changed do
          @area.queue_redraw_all
        end
      }
      
      @alpha_spinbox = spinbox(0, 100) {
        label 'alpha'
        value 100
        
        on_changed do
          @area.queue_redraw_all
        end
      }
    }
    
    @area = area {
      on_draw do |area_draw_params|
        rectangle(@x_spinbox.value, @y_spinbox.value, @width_spinbox.value, @height_spinbox.value) { # a dynamic path is added semi-declaratively inside on_draw block
          fill r: @red_spinbox.value, g: @green_spinbox.value, b: @blue_spinbox.value, a: @alpha_spinbox.value / 100.0
        }
      end
    }
  }
}.show
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 3 (declarative stable `path` approach with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class DynamicArea
  include Glimmer
  
  attr_accessor :rectangle_x, :rectangle_y, :rectangle_width, :rectangle_height, :rectangle_red, :rectangle_green, :rectangle_blue, :rectangle_alpha
  
  def initialize
    @rectangle_x = 25
    @rectangle_y = 25
    @rectangle_width = 150
    @rectangle_height = 150
    @rectangle_red = 102
    @rectangle_green = 102
    @rectangle_blue = 204
    @rectangle_alpha = 100
  end
  
  def rectangle_fill
    { r: rectangle_red, g: rectangle_green, b: rectangle_blue, a: rectangle_alpha / 100.0 }
  end
  
  def launch
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
            value <=> [self, :rectangle_x]
          }
          
          @y_spinbox = spinbox(0, 1000) {
            label 'y'
            value <=> [self, :rectangle_y]
          }
          
          @width_spinbox = spinbox(0, 1000) {
            label 'width'
            value <=> [self, :rectangle_width]
          }
          
          @height_spinbox = spinbox(0, 1000) {
            label 'height'
            value <=> [self, :rectangle_height]
          }
          
          @red_spinbox = spinbox(0, 255) {
            label 'red'
            value <=> [self, :rectangle_red]
          }
          
          @green_spinbox = spinbox(0, 255) {
            label 'green'
            value <=> [self, :rectangle_green]
          }
          
          @blue_spinbox = spinbox(0, 255) {
            label 'blue'
            value <=> [self, :rectangle_blue]
          }
          
          @alpha_spinbox = spinbox(0, 100) {
            label 'alpha'
            value <=> [self, :rectangle_alpha]
          }
        }
        
        area {
          @rectangle = rectangle { # stable implicit path shape
            x      <= [self, :rectangle_x]
            y      <= [self, :rectangle_y]
            width  <= [self, :rectangle_width]
            height <= [self, :rectangle_height]
            fill   <= [self, :rectangle_fill, computed_by: [:rectangle_red, :rectangle_green, :rectangle_blue, :rectangle_alpha]]
          }
        }
      }
    }.show
  end
end

DynamicArea.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 4 (declarative stable `path` approach without [data-binding](#data-binding)):

```ruby
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
```

## Editable Column Table

[examples/editable_column_table.rb](/examples/editable_column_table.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/editable_column_table.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/editable_column_table'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-editable-column-table-editing.png](/images/glimmer-dsl-libui-mac-editable-column-table-editing.png) ![glimmer-dsl-libui-mac-editable-column-table-edited.png](/images/glimmer-dsl-libui-mac-editable-column-table-edited.png) | ![glimmer-dsl-libui-windows-editable-column-table-editing.png](/images/glimmer-dsl-libui-windows-editable-column-table-editing.png) ![glimmer-dsl-libui-windows-editable-column-table-edited.png](/images/glimmer-dsl-libui-windows-editable-column-table-edited.png) | ![glimmer-dsl-libui-linux-editable-column-table-editing.png](/images/glimmer-dsl-libui-linux-editable-column-table-editing.png) ![glimmer-dsl-libui-linux-editable-column-table-edited.png](/images/glimmer-dsl-libui-linux-editable-column-table-edited.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

data = [
  %w[cat calm meow],
  %w[dog loyal woof],
  %w[chicken bird cock-a-doodle-doo],
  %w[horse fast neigh],
  %w[cow slow moo]
]

window('Editable column animal sounds', 400, 200) {
  horizontal_box {
    table {
      text_column('Animal')
      text_column('Description')
      text_column('Sound (Editable)') {
        editable true
      }

      cell_rows data
      
      on_edited do |row, row_data| # only fires on direct table editing
        puts "Row #{row} edited: #{row_data}"
        $stdout.flush
      end
    }
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

## Editable Table

[examples/editable_table.rb](/examples/editable_table.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/editable_table.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/editable_table'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-editable-table.png](/images/glimmer-dsl-libui-mac-editable-table.png) ![glimmer-dsl-libui-mac-editable-table-editing.png](/images/glimmer-dsl-libui-mac-editable-table-editing.png) ![glimmer-dsl-libui-mac-editable-table-edited.png](/images/glimmer-dsl-libui-mac-editable-table-edited.png) | ![glimmer-dsl-libui-windows-editable-table.png](/images/glimmer-dsl-libui-windows-editable-table.png) ![glimmer-dsl-libui-windows-editable-table-editing.png](/images/glimmer-dsl-libui-windows-editable-table-editing.png) ![glimmer-dsl-libui-windows-editable-table-edited.png](/images/glimmer-dsl-libui-windows-editable-table-edited.png) | ![glimmer-dsl-libui-linux-editable-table.png](/images/glimmer-dsl-libui-linux-editable-table.png) ![glimmer-dsl-libui-linux-editable-table-editing.png](/images/glimmer-dsl-libui-linux-editable-table-editing.png) ![glimmer-dsl-libui-linux-editable-table-edited.png](/images/glimmer-dsl-libui-linux-editable-table-edited.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

data = [
  %w[cat meow],
  %w[dog woof],
  %w[chicken cock-a-doodle-doo],
  %w[horse neigh],
  %w[cow moo]
]

window('Editable animal sounds', 300, 200) {
  horizontal_box {
    table {
      text_column('Animal')
      text_column('Description')

      editable true
      cell_rows data
      
      on_changed do |row, type, row_data| # fires on all changes (even ones happening through data array)
        puts "Row #{row} #{type}: #{row_data}"
      end
      
      on_edited do |row, row_data| # only fires on direct table editing
        puts "Row #{row} edited: #{row_data}"
      end
    }
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

## Form Table

[examples/form_table.rb](/examples/form_table.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/form_table.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/form_table'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-form-table.png](/images/glimmer-dsl-libui-mac-form-table.png) ![glimmer-dsl-libui-mac-form-table-contact-entered.png](/images/glimmer-dsl-libui-mac-form-table-contact-entered.png) ![glimmer-dsl-libui-mac-form-table-filtered.png](/images/glimmer-dsl-libui-mac-form-table-filtered.png) | ![glimmer-dsl-libui-windows-form-table.png](/images/glimmer-dsl-libui-windows-form-table.png) ![glimmer-dsl-libui-windows-form-table-contact-entered.png](/images/glimmer-dsl-libui-windows-form-table-contact-entered.png) ![glimmer-dsl-libui-windows-form-table-filtered.png](/images/glimmer-dsl-libui-windows-form-table-filtered.png) | ![glimmer-dsl-libui-linux-form-table.png](/images/glimmer-dsl-libui-linux-form-table.png) ![glimmer-dsl-libui-linux-form-table-contact-entered.png](/images/glimmer-dsl-libui-linux-form-table-contact-entered.png) ![glimmer-dsl-libui-linux-form-table-filtered.png](/images/glimmer-dsl-libui-linux-form-table-filtered.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with explicit [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class FormTable
  Contact = Struct.new(:name, :email, :phone, :city, :state)
  
  include Glimmer
  
  attr_accessor :contacts, :name, :email, :phone, :city, :state, :filter_value
  
  def initialize
    @contacts = [
      Contact.new('Lisa Sky', 'lisa@sky.com', '720-523-4329', 'Denver', 'CO'),
      Contact.new('Jordan Biggins', 'jordan@biggins.com', '617-528-5399', 'Boston', 'MA'),
      Contact.new('Mary Glass', 'mary@glass.com', '847-589-8788', 'Elk Grove Village', 'IL'),
      Contact.new('Darren McGrath', 'darren@mcgrath.com', '206-539-9283', 'Seattle', 'WA'),
      Contact.new('Melody Hanheimer', 'melody@hanheimer.com', '213-493-8274', 'Los Angeles', 'CA'),
    ]
  end
  
  def launch
    window('Contacts', 600, 600) {
      margined true
      
      vertical_box {
        form {
          stretchy false
          
          entry {
            label 'Name'
            text <=> [self, :name] # bidirectional data-binding between entry text and self.name
          }
          
          entry {
            label 'Email'
            text <=> [self, :email]
          }
          
          entry {
            label 'Phone'
            text <=> [self, :phone]
          }
          
          entry {
            label 'City'
            text <=> [self, :city]
          }
          
          entry {
            label 'State'
            text <=> [self, :state]
          }
        }
        
        button('Save Contact') {
          stretchy false
          
          on_clicked do
            new_row = [name, email, phone, city, state]
            if new_row.map(&:to_s).include?('')
              msg_box_error('Validation Error!', 'All fields are required! Please make sure to enter a value for all fields.')
            else
              @contacts << Contact.new(*new_row) # automatically inserts a row into the table due to explicit data-binding
              @unfiltered_contacts = @contacts.dup
              self.name = '' # automatically clears name entry through explicit data-binding
              self.email = ''
              self.phone = ''
              self.city = ''
              self.state = ''
            end
          end
        }
        
        search_entry {
          stretchy false
          # bidirectional data-binding of text to self.filter_value with after_write option
          text <=> [self, :filter_value,
            after_write: ->(filter_value) { # execute after write to self.filter_value
              @unfiltered_contacts ||= @contacts.dup
              # Unfilter first to remove any previous filters
              self.contacts = @unfiltered_contacts.dup # affects table indirectly through explicit data-binding
              # Now, apply filter if entered
              unless filter_value.empty?
                self.contacts = @contacts.filter do |contact| # affects table indirectly through explicit data-binding
                  contact.members.any? do |attribute|
                    contact[attribute].to_s.downcase.include?(filter_value.downcase)
                  end
                end
              end
            }
          ]
        }
        
        table {
          text_column('Name')
          text_column('Email')
          text_column('Phone')
          text_column('City')
          text_column('State')
    
          editable true
          cell_rows <=> [self, :contacts] # explicit data-binding to self.contacts Model Array, auto-inferring model attribute names from underscored table column names by convention
          
          on_changed do |row, type, row_data|
            puts "Row #{row} #{type}: #{row_data}"
            $stdout.flush # for Windows
          end
          
          on_edited do |row, row_data| # only fires on direct table editing
            puts "Row #{row} edited: #{row_data}"
            $stdout.flush # for Windows
          end
        }
      }
    }.show
  end
end

FormTable.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (with explicit [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class FormTable
  Contact = Struct.new(:name, :email, :phone, :city, :state_province)
  
  include Glimmer
  
  attr_accessor :contacts, :name, :email, :phone, :city, :state, :filter_value
  
  def initialize
    @contacts = [
      Contact.new('Lisa Sky', 'lisa@sky.com', '720-523-4329', 'Denver', 'CO'),
      Contact.new('Jordan Biggins', 'jordan@biggins.com', '617-528-5399', 'Boston', 'MA'),
      Contact.new('Mary Glass', 'mary@glass.com', '847-589-8788', 'Elk Grove Village', 'IL'),
      Contact.new('Darren McGrath', 'darren@mcgrath.com', '206-539-9283', 'Seattle', 'WA'),
      Contact.new('Melody Hanheimer', 'melody@hanheimer.com', '213-493-8274', 'Los Angeles', 'CA'),
    ]
  end
  
  def launch
    window('Contacts', 600, 600) {
      margined true
      
      vertical_box {
        form {
          stretchy false
          
          entry {
            label 'Name'
            text <=> [self, :name] # bidirectional data-binding between entry text and self.name
          }
          
          entry {
            label 'Email'
            text <=> [self, :email]
          }
          
          entry {
            label 'Phone'
            text <=> [self, :phone]
          }
          
          entry {
            label 'City'
            text <=> [self, :city]
          }
          
          entry {
            label 'State'
            text <=> [self, :state]
          }
        }
        
        button('Save Contact') {
          stretchy false
          
          on_clicked do
            new_row = [name, email, phone, city, state]
            if new_row.map(&:to_s).include?('')
              msg_box_error('Validation Error!', 'All fields are required! Please make sure to enter a value for all fields.')
            else
              @contacts << Contact.new(*new_row) # automatically inserts a row into the table due to implicit data-binding
              @unfiltered_contacts = @contacts.dup
              self.name = '' # automatically clears name entry through explicit data-binding
              self.email = ''
              self.phone = ''
              self.city = ''
              self.state = ''
            end
          end
        }
        
        search_entry {
          stretchy false
          # bidirectional data-binding of text to self.filter_value with after_write option
          text <=> [self, :filter_value,
            after_write: ->(filter_value) { # execute after write to self.filter_value
              @unfiltered_contacts ||= @contacts.dup
              # Unfilter first to remove any previous filters
              self.contacts = @unfiltered_contacts.dup # affects table indirectly through explicit data-binding
              # Now, apply filter if entered
              unless filter_value.empty?
                self.contacts = @contacts.filter do |contact| # affects table indirectly through explicit data-binding
                  contact.members.any? do |attribute|
                    contact[attribute].to_s.downcase.include?(filter_value.downcase)
                  end
                end
              end
            }
          ]
        }
        
        table {
          text_column('Name')
          text_column('Email')
          text_column('Phone')
          text_column('City')
          text_column('State')
    
          editable true
          cell_rows <=> [self, :contacts, column_attributes: {'State' => :state_province}] # explicit data-binding to Model Array with column_attributes mapping for a specific column
          
          on_changed do |row, type, row_data|
            puts "Row #{row} #{type}: #{row_data}"
            $stdout.flush # for Windows
          end
          
          on_edited do |row, row_data| # only fires on direct table editing
            puts "Row #{row} edited: #{row_data}"
            $stdout.flush # for Windows
          end
        }
      }
    }.show
  end
end

FormTable.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 3 (with explicit [data-binding](#data-binding)):

```ruby

require 'glimmer-dsl-libui'

class FormTable
  Contact = Struct.new(:full_name, :email_address, :phone_number, :city_or_town, :state_or_province)
  
  include Glimmer
  
  attr_accessor :contacts, :name, :email, :phone, :city, :state, :filter_value
  
  def initialize
    @contacts = [
      Contact.new('Lisa Sky', 'lisa@sky.com', '720-523-4329', 'Denver', 'CO'),
      Contact.new('Jordan Biggins', 'jordan@biggins.com', '617-528-5399', 'Boston', 'MA'),
      Contact.new('Mary Glass', 'mary@glass.com', '847-589-8788', 'Elk Grove Village', 'IL'),
      Contact.new('Darren McGrath', 'darren@mcgrath.com', '206-539-9283', 'Seattle', 'WA'),
      Contact.new('Melody Hanheimer', 'melody@hanheimer.com', '213-493-8274', 'Los Angeles', 'CA'),
    ]
  end
  
  def launch
    window('Contacts', 600, 600) {
      margined true
      
      vertical_box {
        form {
          stretchy false
          
          entry {
            label 'Name'
            text <=> [self, :name] # bidirectional data-binding between entry text and self.name
          }
          
          entry {
            label 'Email'
            text <=> [self, :email]
          }
          
          entry {
            label 'Phone'
            text <=> [self, :phone]
          }
          
          entry {
            label 'City'
            text <=> [self, :city]
          }
          
          entry {
            label 'State'
            text <=> [self, :state]
          }
        }
        
        button('Save Contact') {
          stretchy false
          
          on_clicked do
            new_row = [name, email, phone, city, state]
            if new_row.map(&:to_s).include?('')
              msg_box_error('Validation Error!', 'All fields are required! Please make sure to enter a value for all fields.')
            else
              @contacts << Contact.new(*new_row) # automatically inserts a row into the table due to implicit data-binding
              @unfiltered_contacts = @contacts.dup
              self.name = '' # automatically clears name entry through explicit data-binding
              self.email = ''
              self.phone = ''
              self.city = ''
              self.state = ''
            end
          end
        }
        
        search_entry {
          stretchy false
          # bidirectional data-binding of text to self.filter_value with after_write option
          text <=> [self, :filter_value,
            after_write: ->(filter_value) { # execute after write to self.filter_value
              @unfiltered_contacts ||= @contacts.dup
              # Unfilter first to remove any previous filters
              self.contacts = @unfiltered_contacts.dup # affects table indirectly through explicit data-binding
              # Now, apply filter if entered
              unless filter_value.empty?
                self.contacts = @contacts.filter do |contact| # affects table indirectly through explicit data-binding
                  contact.members.any? do |attribute|
                    contact[attribute].to_s.downcase.include?(filter_value.downcase)
                  end
                end
              end
            }
          ]
        }
        
        table {
          text_column('Name')
          text_column('Email')
          text_column('Phone')
          text_column('City')
          text_column('State')
    
          editable true
          cell_rows <=> [self, :contacts, column_attributes: [:full_name, :email_address, :phone_number, :city_or_town, :state_or_province]] # explicit data-binding to Model Array with column_attributes mapping for all columns
          
          on_changed do |row, type, row_data|
            puts "Row #{row} #{type}: #{row_data}"
            $stdout.flush # for Windows
          end
          
          on_edited do |row, row_data| # only fires on direct table editing
            puts "Row #{row} edited: #{row_data}"
            $stdout.flush # for Windows
          end
        }
      }
    }.show
  end
end

FormTable.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 4 (with explicit [data-binding](#data-binding) to raw data):

```ruby
require 'glimmer-dsl-libui'

class FormTable
  include Glimmer
  
  attr_accessor :data, :name, :email, :phone, :city, :state, :filter_value
  
  def initialize
    @data = [
      ['Lisa Sky', 'lisa@sky.com', '720-523-4329', 'Denver', 'CO'],
      ['Jordan Biggins', 'jordan@biggins.com', '617-528-5399', 'Boston', 'MA'],
      ['Mary Glass', 'mary@glass.com', '847-589-8788', 'Elk Grove Village', 'IL'],
      ['Darren McGrath', 'darren@mcgrath.com', '206-539-9283', 'Seattle', 'WA'],
      ['Melody Hanheimer', 'melody@hanheimer.com', '213-493-8274', 'Los Angeles', 'CA'],
    ]
  end
  
  def launch
    window('Contacts', 600, 600) {
      margined true
      
      vertical_box {
        form {
          stretchy false
          
          entry {
            label 'Name'
            text <=> [self, :name] # bidirectional data-binding between entry text and self.name
          }
          
          entry {
            label 'Email'
            text <=> [self, :email]
          }
          
          entry {
            label 'Phone'
            text <=> [self, :phone]
          }
          
          entry {
            label 'City'
            text <=> [self, :city]
          }
          
          entry {
            label 'State'
            text <=> [self, :state]
          }
        }
        
        button('Save Contact') {
          stretchy false
          
          on_clicked do
            new_row = [name, email, phone, city, state]
            if new_row.map(&:to_s).include?('')
              msg_box_error('Validation Error!', 'All fields are required! Please make sure to enter a value for all fields.')
            else
              data << new_row # automatically inserts a row into the table due to implicit data-binding
              @unfiltered_data = data.dup
              self.name = '' # automatically clears name entry through explicit data-binding
              self.email = ''
              self.phone = ''
              self.city = ''
              self.state = ''
            end
          end
        }
        
        search_entry {
          stretchy false
          # bidirectional data-binding of text to self.filter_value with after_write option
          text <=> [self, :filter_value,
            after_write: ->(filter_value) { # execute after write to self.filter_value
              @unfiltered_data ||= data.dup
              # Unfilter first to remove any previous filters
              data.replace(@unfiltered_data) # affects table indirectly through implicit data-binding
              # Now, apply filter if entered
              unless filter_value.empty?
                data.filter! do |row_data| # affects table indirectly through implicit data-binding
                  row_data.any? do |cell|
                    cell.to_s.downcase.include?(filter_value.downcase)
                  end
                end
              end
            }
          ]
        }
        
        table {
          text_column('Name')
          text_column('Email')
          text_column('Phone')
          text_column('City')
          text_column('State')
          
          editable true
          cell_rows <=> [self, :data] # explicit data-binding to raw data Array of Arrays
          
          on_changed do |row, type, row_data|
            puts "Row #{row} #{type}: #{row_data}"
            $stdout.flush # for Windows
          end
          
          on_edited do |row, row_data| # only fires on direct table editing
            puts "Row #{row} edited: #{row_data}"
            $stdout.flush # for Windows
          end
        }
      }
    }.show
  end
end

FormTable.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 5 (with implicit [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

data = [
  ['Lisa Sky', 'lisa@sky.com', '720-523-4329', 'Denver', 'CO'],
  ['Jordan Biggins', 'jordan@biggins.com', '617-528-5399', 'Boston', 'MA'],
  ['Mary Glass', 'mary@glass.com', '847-589-8788', 'Elk Grove Village', 'IL'],
  ['Darren McGrath', 'darren@mcgrath.com', '206-539-9283', 'Seattle', 'WA'],
  ['Melody Hanheimer', 'melody@hanheimer.com', '213-493-8274', 'Los Angeles', 'CA'],
]

window('Contacts', 600, 600) {
  margined true
  
  vertical_box {
    form {
      stretchy false
      
      @name_entry = entry {
        label 'Name'
      }
      
      @email_entry = entry {
        label 'Email'
      }
      
      @phone_entry = entry {
        label 'Phone'
      }
      
      @city_entry = entry {
        label 'City'
      }
      
      @state_entry = entry {
        label 'State'
      }
    }
    
    button('Save Contact') {
      stretchy false
      
      on_clicked do
        new_row = [@name_entry.text, @email_entry.text, @phone_entry.text, @city_entry.text, @state_entry.text]
        if new_row.map(&:to_s).include?('')
          msg_box_error('Validation Error!', 'All fields are required! Please make sure to enter a value for all fields.')
        else
          data << new_row # automatically inserts a row into the table due to implicit data-binding
          @unfiltered_data = data.dup
          @name_entry.text = ''
          @email_entry.text = ''
          @phone_entry.text = ''
          @city_entry.text = ''
          @state_entry.text = ''
        end
      end
    }
    
    search_entry { |se|
      stretchy false
      
      on_changed do
        filter_value = se.text
        @unfiltered_data ||= data.dup
        # Unfilter first to remove any previous filters
        data.replace(@unfiltered_data) # affects table indirectly through implicit data-binding
        # Now, apply filter if entered
        unless filter_value.empty?
          data.filter! do |row_data| # affects table indirectly through implicit data-binding
            row_data.any? do |cell|
              cell.to_s.downcase.include?(filter_value.downcase)
            end
          end
        end
      end
    }
    
    table {
      text_column('Name')
      text_column('Email')
      text_column('Phone')
      text_column('City')
      text_column('State')

      editable true
      cell_rows data # implicit data-binding to raw data Array of Arrays
      
      on_changed do |row, type, row_data|
        puts "Row #{row} #{type}: #{row_data}"
        $stdout.flush # for Windows
      end
      
      on_edited do |row, row_data| # only fires on direct table editing
        puts "Row #{row} edited: #{row_data}"
        $stdout.flush # for Windows
      end
    }
  }
}.show
```

## Paginated Refined Table

[examples/paginated_refined_table.rb](/examples/paginated_refined_table.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/paginated_refined_table.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/paginated_refined_table'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-paginated-refined-table.png](/images/glimmer-dsl-libui-mac-paginated-refined-table.png)| ![glimmer-dsl-libui-windows-paginated-refined-table.png](/images/glimmer-dsl-libui-windows-paginated-refined-table.png)| ![glimmer-dsl-libui-linux-paginated-refined-table.png](/images/glimmer-dsl-libui-linux-paginated-refined-table.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

class PaginatedRefinedTable
  Contact = Struct.new(:name, :email, :phone, :city, :state)
  
  include Glimmer::LibUI::Application
  
  NAMES_FIRST = %w[
    Liam Noah William James Oliver Benjamin Elijah Lucas Mason Logan Alexander Ethan Jacob Michael Daniel Henry Jackson Sebastian
    Aiden Matthew Samuel David Joseph Carter Owen Wyatt John Jack Luke Jayden Dylan Grayson Levi Isaac Gabriel Julian Mateo
    Anthony Jaxon Lincoln Joshua Christopher Andrew Theodore Caleb Ryan Asher Nathan Thomas Leo Isaiah Charles Josiah Hudson
    Christian Hunter Connor Eli Ezra Aaron Landon Adrian Jonathan Nolan Jeremiah Easton Elias Colton Cameron Carson Robert Angel
    Maverick Nicholas Dominic Jaxson Greyson Adam Ian Austin Santiago Jordan Cooper Brayden Roman Evan Ezekiel Xaviar Jose Jace
    Jameson Leonardo Axel Everett Kayden Miles Sawyer Jason Emma Olivia Bartholomew Corey Danielle Eva Felicity
  ]
  
  NAMES_LAST = %w[
    Smith Johnson Williams Brown Jones Miller Davis Wilson Anderson Taylor George Harrington Iverson Jackson Korby Levinson
  ]
  
  CITIES = [
    'Bellesville', 'Lombardia', 'Steepleton', 'Deerenstein', 'Schwartz', 'Hollandia', 'Saint Pete', 'Grandville', 'London',
    'Berlin', 'Elktown', 'Paris', 'Garrison', 'Muncy', 'St Louis',
  ]
  
  STATES = [ 'AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA',
             'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME',
             'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM',
             'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX',
             'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY']
             
  attr_accessor :contacts, :name, :email, :phone, :city, :state, :filter_value, :index
  
  before_body do
    @contacts = 50_000.times.map do |n|
      n += 1
      first_name = NAMES_FIRST.sample
      last_name = NAMES_LAST.sample
      city = CITIES.sample
      state = STATES.sample
      Contact.new("#{first_name} #{last_name}", "#{first_name.downcase}#{n}@#{last_name.downcase}.com", '555-555-5555', city, state)
    end
  end
  
  body {
    window("50,000 Paginated Contacts", 600, 700) {
      margined true
      
      vertical_box {
        form {
          stretchy false
          
          entry {
            label 'Name'
            text <=> [self, :name] # bidirectional data-binding between entry text and self.name
          }
          
          entry {
            label 'Email'
            text <=> [self, :email]
          }
          
          entry {
            label 'Phone'
            text <=> [self, :phone]
          }
          
          entry {
            label 'City'
            text <=> [self, :city]
          }
          
          entry {
            label 'State'
            text <=> [self, :state]
          }
        }
        
        button('Save Contact') {
          stretchy false
          
          on_clicked do
            new_row = [name, email, phone, city, state]
            if new_row.map(&:to_s).include?('')
              msg_box_error('Validation Error!', 'All fields are required! Please make sure to enter a value for all fields.')
            else
              @contacts << Contact.new(*new_row) # automatically inserts a row into the table due to explicit data-binding
              @unfiltered_contacts = @contacts.dup
              self.name = '' # automatically clears name entry through explicit data-binding
              self.email = ''
              self.phone = ''
              self.city = ''
              self.state = ''
            end
          end
        }
        
        refined_table(
          model_array: contacts,
          table_columns: {
            'Name'  => {text: {editable: false}},
            'Email' => :text,
            'Phone' => :text,
            'City'  => :text,
            'State' => :text,
          },
          table_editable: true,
          per_page: 20,
          # page: 1, # initial page is 1
          # visible_page_count: true, # page count can be shown if preferred
        )
      }
    }
  }
end

PaginatedRefinedTable.launch
```

## Grid

[examples/grid.rb](/examples/grid.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/grid.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/grid'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-grid-span.png](/images/glimmer-dsl-libui-mac-grid-span.png) ![glimmer-dsl-libui-mac-grid-expand.png](/images/glimmer-dsl-libui-mac-grid-expand.png) ![glimmer-dsl-libui-mac-grid-align.png](/images/glimmer-dsl-libui-mac-grid-align.png) | ![glimmer-dsl-libui-windows-grid-span.png](/images/glimmer-dsl-libui-windows-grid-span.png) ![glimmer-dsl-libui-windows-grid-expand.png](/images/glimmer-dsl-libui-windows-grid-expand.png) ![glimmer-dsl-libui-windows-grid-align.png](/images/glimmer-dsl-libui-windows-grid-align.png) | ![glimmer-dsl-libui-linux-grid-span.png](/images/glimmer-dsl-libui-linux-grid-span.png) ![glimmer-dsl-libui-linux-grid-expand.png](/images/glimmer-dsl-libui-linux-grid-expand.png) ![glimmer-dsl-libui-linux-grid-align.png](/images/glimmer-dsl-libui-linux-grid-align.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Grid') {
  tab {
    tab_item('Span') {
      grid {
        4.times do |top_value|
          4.times do |left_value|
            label("(#{left_value}, #{top_value}) xspan1\nyspan1") {
              left left_value
              top top_value
              hexpand true
              vexpand true
            }
          end
        end
        label("(0, 4) xspan2\nyspan1 more text fits horizontally") {
          left 0
          top 4
          xspan 2
        }
        label("(2, 4) xspan2\nyspan1 more text fits horizontally") {
          left 2
          top 4
          xspan 2
        }
        label("(0, 5) xspan1\nyspan2\nmore text\nfits vertically") {
          left 0
          top 5
          yspan 2
        }
        label("(0, 7) xspan1\nyspan2\nmore text\nfits vertically") {
          left 0
          top 7
          yspan 2
        }
        label("(1, 5) xspan3\nyspan4 a lot more text fits horizontally than before\nand\neven\na lot\nmore text\nfits vertically\nthan\nbefore") {
          left 1
          top 5
          xspan 3
          yspan 4
        }
      }
    }
    tab_item('Expand') {
      grid {
        label("(0, 0) hexpand/vexpand\nall available horizontal space is taken\nand\nall\navailable\nvertical\nspace\nis\ntaken") {
          left 0
          top 0
          hexpand true
          vexpand true
        }
        label("(1, 0)") {
          left 1
          top 0
        }
        label("(0, 1)") {
          left 0
          top 1
        }
        label("(1, 1)") {
          left 1
          top 1
        }
      }
    }
    tab_item('Align') {
      grid {
        label("(0, 0) halign/valign fill\nall available horizontal space is taken\nand\nall\navailable\nvertical\nspace\nis\ntaken") {
          left 0
          top 0
          hexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          vexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          halign :fill
          valign :fill
        }
        label("(1, 0) halign/valign start") {
          left 1
          top 0
          hexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          vexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          halign :start
          valign :start
        }
        label("(0, 1) halign/valign center") {
          left 0
          top 1
          hexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          vexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          halign :center
          valign :center
        }
        label("(1, 1) halign/valign end") {
          left 1
          top 1
          hexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          vexpand true unless OS.mac? # on Mac, only the first label is given all space, so avoid expanding
          halign :end
          valign :end
        }
      }
    }
  }
}.show
```

## Histogram

[examples/histogram.rb](/examples/histogram.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/histogram.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/histogram'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-histogram.png](/images/glimmer-dsl-libui-mac-histogram.png) | ![glimmer-dsl-libui-windows-histogram.png](/images/glimmer-dsl-libui-windows-histogram.png) | ![glimmer-dsl-libui-linux-histogram.png](/images/glimmer-dsl-libui-linux-histogram.png)

[LibUI](https://github.com/kojix2/LibUI) Original Version:

```ruby
# https://github.com/jamescook/libui-ruby/blob/master/example/histogram.rb

require 'libui'

UI = LibUI

X_OFF_LEFT   = 20
Y_OFF_TOP    = 20
X_OFF_RIGHT  = 20
Y_OFF_BOTTOM = 20
POINT_RADIUS = 5

init         = UI.init
handler      = UI::FFI::AreaHandler.malloc
histogram    = UI.new_area(handler)
brush        = UI::FFI::DrawBrush.malloc
color_button = UI.new_color_button
blue         = 0x1E90FF
datapoints   = []

def graph_size(area_width, area_height)
  graph_width = area_width - X_OFF_LEFT - X_OFF_RIGHT
  graph_height = area_height - Y_OFF_TOP - Y_OFF_BOTTOM
  [graph_width, graph_height]
end

matrix = UI::FFI::DrawMatrix.malloc

def point_locations(datapoints, width, height)
  xincr = width / 9.0 # 10 - 1 to make the last point be at the end
  yincr = height / 100.0

  data = []
  datapoints.each_with_index do |dp, i|
    val = 100 - UI.spinbox_value(dp)
    data << [xincr * i, yincr * val]
    i += 1
  end

  data
end

def construct_graph(datapoints, width, height, should_extend)
  locations = point_locations(datapoints, width, height)
  path = UI.draw_new_path(0) # winding
  first_location = locations[0] # x and y
  UI.draw_path_new_figure(path, first_location[0], first_location[1])
  locations.each do |loc|
    UI.draw_path_line_to(path, loc[0], loc[1])
  end

  if should_extend
    UI.draw_path_line_to(path, width, height)
    UI.draw_path_line_to(path, 0, height)
    UI.draw_path_close_figure(path)
  end

  UI.draw_path_end(path)

  path
end

handler_draw_event = Fiddle::Closure::BlockCaller.new(
  0, [1, 1, 1]
) do |_area_handler, _area, area_draw_params|
  area_draw_params = UI::FFI::AreaDrawParams.new(area_draw_params)
  path = UI.draw_new_path(0) # winding
  UI.draw_path_add_rectangle(path, 0, 0, area_draw_params.AreaWidth, area_draw_params.AreaHeight)
  UI.draw_path_end(path)
  set_solid_brush(brush, 0xFFFFFF, 1.0) # white
  UI.draw_fill(area_draw_params.Context, path, brush.to_ptr)
  UI.draw_free_path(path)
  dsp = UI::FFI::DrawStrokeParams.malloc
  dsp.Cap = 0 # flat
  dsp.Join = 0 # miter
  dsp.Thickness = 2
  dsp.MiterLimit = 10 # DEFAULT_MITER_LIMIT
  dashes = Fiddle::Pointer.malloc(8)
  dsp.Dashes = dashes
  dsp.NumDashes = 0
  dsp.DashPhase = 0

  # draw axes
  set_solid_brush(brush, 0x000000, 1.0) # black
  graph_width, graph_height = *graph_size(area_draw_params.AreaWidth, area_draw_params.AreaHeight)

  path = UI.draw_new_path(0) # winding
  UI.draw_path_new_figure(path, X_OFF_LEFT, Y_OFF_TOP)
  UI.draw_path_line_to(path, X_OFF_LEFT, Y_OFF_TOP + graph_height)
  UI.draw_path_line_to(path, X_OFF_LEFT + graph_width, Y_OFF_TOP + graph_height)
  UI.draw_path_end(path)
  UI.draw_stroke(area_draw_params.Context, path, brush, dsp)
  UI.draw_free_path(path)

  # now transform the coordinate space so (0, 0) is the top-left corner of the graph
  UI.draw_matrix_set_identity(matrix)
  UI.draw_matrix_translate(matrix, X_OFF_LEFT, Y_OFF_TOP)
  UI.draw_transform(area_draw_params.Context, matrix)

  # now get the color for the graph itself and set up the brush
  #  uiColorButtonColor(colorButton, &graphR, &graphG, &graphB, &graphA)
  graph_r = Fiddle::Pointer.malloc(8) # double
  graph_g = Fiddle::Pointer.malloc(8) # double
  graph_b = Fiddle::Pointer.malloc(8) # double
  graph_a = Fiddle::Pointer.malloc(8) # double

  UI.color_button_color(color_button, graph_r, graph_g, graph_b, graph_a)
  brush.Type = 0 # solid
  brush.R = graph_r[0, 8].unpack1('d')
  brush.G = graph_g[0, 8].unpack1('d')
  brush.B = graph_b[0, 8].unpack1('d')

  # now create the fill for the graph below the graph line
  path = construct_graph(datapoints, graph_width, graph_height, true)
  brush.A = graph_a[0, 8].unpack1('d') / 2.0
  UI.draw_fill(area_draw_params.Context, path, brush)
  UI.draw_free_path(path)

  # now draw the histogram line
  path = construct_graph(datapoints, graph_width, graph_height, false)
  brush.A = graph_a[0, 8].unpack1('d')
  UI.draw_stroke(area_draw_params.Context, path, brush, dsp)
  UI.draw_free_path(path)
end

handler.Draw         = handler_draw_event

# Assigning to local variables
# This is intended to protect Fiddle::Closure from garbage collection.
# See https://github.com/kojix2/LibUI/issues/8
handler.MouseEvent   = (c1 = Fiddle::Closure::BlockCaller.new(0, [0]) {})
handler.MouseCrossed = (c2 = Fiddle::Closure::BlockCaller.new(0, [0]) {})
handler.DragBroken   = (c3 = Fiddle::Closure::BlockCaller.new(0, [0]) {})
handler.KeyEvent     = (c4 = Fiddle::Closure::BlockCaller.new(1, [0]) { 0 })

UI.freeInitError(init) unless init.nil?

hbox = UI.new_horizontal_box
UI.box_set_padded(hbox, 1)

vbox = UI.new_vertical_box
UI.box_set_padded(vbox, 1)
UI.box_append(hbox, vbox, 0)
UI.box_append(hbox, histogram, 1)

datapoints = Array.new(10) do
  UI.new_spinbox(0, 100).tap do |datapoint|
    UI.spinbox_set_value(datapoint, Random.new.rand(90))
    UI.spinbox_on_changed(datapoint) do
      UI.area_queue_redraw_all(histogram)
    end
    UI.box_append(vbox, datapoint, 0)
  end
end

def set_solid_brush(brush, color, alpha)
  brush.Type = 0 # solid
  brush.R = ((color >> 16) & 0xFF) / 255.0
  brush.G = ((color >> 8) & 0xFF) / 255.0
  brush.B = (color & 0xFF) / 255.0
  brush.A = alpha
  brush
end

set_solid_brush(brush, blue, 1.0)
UI.color_button_set_color(color_button, brush.R, brush.G, brush.B, brush.A)

UI.color_button_on_changed(color_button) do
  UI.area_queue_redraw_all(histogram)
end

UI.box_append(vbox, color_button, 0)

MAIN_WINDOW = UI.new_window('histogram example', 640, 480, 1)
UI.window_set_margined(MAIN_WINDOW, 1)
UI.window_set_child(MAIN_WINDOW, hbox)

should_quit = proc do |_ptr|
  UI.control_destroy(MAIN_WINDOW)
  UI.quit
  0
end

UI.window_on_closing(MAIN_WINDOW, should_quit)
UI.on_should_quit(should_quit)
UI.control_show(MAIN_WINDOW)

UI.main
UI.quit
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
# https://github.com/jamescook/libui-ruby/blob/master/example/histogram.rb

require 'glimmer-dsl-libui'

class Histogram
  include Glimmer
  
  X_OFF_LEFT   = 20
  Y_OFF_TOP    = 20
  X_OFF_RIGHT  = 20
  Y_OFF_BOTTOM = 20
  POINT_RADIUS = 5
  COLOR_BLUE   = Glimmer::LibUI.interpret_color(0x1E90FF)
  
  attr_accessor :datapoints, :histogram_color
  
  def initialize
    @datapoints   = 10.times.map {Random.new.rand(90)}
    @histogram_color        = COLOR_BLUE
  end
  
  def graph_size(area_width, area_height)
    graph_width = area_width - X_OFF_LEFT - X_OFF_RIGHT
    graph_height = area_height - Y_OFF_TOP - Y_OFF_BOTTOM
    [graph_width, graph_height]
  end
  
  def point_locations(width, height)
    xincr = width / 9.0 # 10 - 1 to make the last point be at the end
    yincr = height / 100.0
  
    @datapoints.each_with_index.map do |value, i|
      val = 100 - value
      [xincr * i, yincr * val]
    end
  end
  
  # method-based custom control representing a graph path
  def graph_path(width, height, should_extend, &block)
    locations = point_locations(width, height).flatten
    path {
      if should_extend
        polygon(locations + [width, height, 0, height])
      else
        polyline(locations)
      end
      
      # apply a transform to the coordinate space for this path so (0, 0) is the top-left corner of the graph
      transform {
        translate X_OFF_LEFT, Y_OFF_TOP
      }
      
      block.call
    }
  end
  
  def launch
    window('histogram example', 640, 480) {
      margined true
      
      horizontal_box {
        vertical_box {
          stretchy false
          
          10.times do |i|
            spinbox(0, 100) { |sb|
              stretchy false
              value <=> [self, "datapoints[#{i}]", after_write: -> { @area.queue_redraw_all }]
            }
          end
          
          color_button { |cb|
            stretchy false
            color <=> [self, :histogram_color, after_write: -> { @area.queue_redraw_all }]
          }
        }
        
        @area = area {
          on_draw do |area_draw_params|
            rectangle(0, 0, area_draw_params[:area_width], area_draw_params[:area_height]) {
              fill 0xFFFFFF
            }
            
            graph_width, graph_height = *graph_size(area_draw_params[:area_width], area_draw_params[:area_height])
          
            figure(X_OFF_LEFT, Y_OFF_TOP) {
              line(X_OFF_LEFT, Y_OFF_TOP + graph_height)
              line(X_OFF_LEFT + graph_width, Y_OFF_TOP + graph_height)
              
              stroke 0x000000, thickness: 2, miter_limit: 10
            }
          
            # now create the fill for the graph below the graph line
            graph_path(graph_width, graph_height, true) {
              fill @histogram_color.merge(a: 0.5)
            }
            
            # now draw the histogram line
            graph_path(graph_width, graph_height, false) {
              stroke @histogram_color.merge(thickness: 2, miter_limit: 10)
            }
          end
        }
      }
    }.show
  end
end

Histogram.new.launch
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby
# https://github.com/jamescook/libui-ruby/blob/master/example/histogram.rb

require 'glimmer-dsl-libui'

include Glimmer

X_OFF_LEFT   = 20
Y_OFF_TOP    = 20
X_OFF_RIGHT  = 20
Y_OFF_BOTTOM = 20
POINT_RADIUS = 5
COLOR_BLUE   = Glimmer::LibUI.interpret_color(0x1E90FF)

@datapoints   = 10.times.map {Random.new.rand(90)}
@color        = COLOR_BLUE

def graph_size(area_width, area_height)
  graph_width = area_width - X_OFF_LEFT - X_OFF_RIGHT
  graph_height = area_height - Y_OFF_TOP - Y_OFF_BOTTOM
  [graph_width, graph_height]
end

def point_locations(width, height)
  xincr = width / 9.0 # 10 - 1 to make the last point be at the end
  yincr = height / 100.0

  @datapoints.each_with_index.map do |value, i|
    val = 100 - value
    [xincr * i, yincr * val]
  end
end

# method-based custom control representing a graph path
def graph_path(width, height, should_extend, &block)
  locations = point_locations(width, height).flatten
  path {
    if should_extend
      polygon(locations + [width, height, 0, height])
    else
      polyline(locations)
    end
    
    # apply a transform to the coordinate space for this path so (0, 0) is the top-left corner of the graph
    transform {
      translate X_OFF_LEFT, Y_OFF_TOP
    }
    
    block.call
  }
end

window('histogram example', 640, 480) {
  margined true
  
  horizontal_box {
    vertical_box {
      stretchy false
      
      10.times do |i|
        spinbox(0, 100) { |sb|
          stretchy false
          value @datapoints[i]
          
          on_changed do
            @datapoints[i] = sb.value
            @area.queue_redraw_all
          end
        }
      end
      
      color_button { |cb|
        stretchy false
        color COLOR_BLUE
        
        on_changed do
          @color = cb.color
          @area.queue_redraw_all
        end
      }
    }
    
    @area = area {
      on_draw do |area_draw_params|
        rectangle(0, 0, area_draw_params[:area_width], area_draw_params[:area_height]) {
          fill 0xFFFFFF
        }
        
        graph_width, graph_height = *graph_size(area_draw_params[:area_width], area_draw_params[:area_height])
      
        figure(X_OFF_LEFT, Y_OFF_TOP) {
          line(X_OFF_LEFT, Y_OFF_TOP + graph_height)
          line(X_OFF_LEFT + graph_width, Y_OFF_TOP + graph_height)
          
          stroke 0x000000, thickness: 2, miter_limit: 10
        }
      
        # now create the fill for the graph below the graph line
        graph_path(graph_width, graph_height, true) {
          fill @color.merge(a: 0.5)
        }
        
        # now draw the histogram line
        graph_path(graph_width, graph_height, false) {
          stroke @color.merge(thickness: 2, miter_limit: 10)
        }
      end
    }
  }
}.show
```

## Login

[examples/login.rb](/examples/login.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/login.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/login'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-login.png](/images/glimmer-dsl-libui-mac-login.png) ![glimmer-dsl-libui-mac-login-logged-in.png](/images/glimmer-dsl-libui-mac-login-logged-in.png) | ![glimmer-dsl-libui-windows-login.png](/images/glimmer-dsl-libui-windows-login.png) ![glimmer-dsl-libui-windows-login-logged-in.png](/images/glimmer-dsl-libui-windows-login-logged-in.png) | ![glimmer-dsl-libui-linux-login.png](/images/glimmer-dsl-libui-linux-login.png) ![glimmer-dsl-libui-linux-login-logged-in.png](/images/glimmer-dsl-libui-linux-login-logged-in.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class Login
  include Glimmer
  
  attr_accessor :username, :password, :logged_in
  
  def launch
    window('Login') {
      margined true
      
      vertical_box {
        form {
          entry {
            label 'Username:'
            text <=> [self, :username]
            enabled <= [self, :logged_in, on_read: :!]
          }
          
          password_entry {
            label 'Password:'
            text <=> [self, :password]
            enabled <= [self, :logged_in, on_read: :!]
          }
        }
        
        horizontal_box {
          button('Login') {
            enabled <= [self, :logged_in, on_read: :!]
            
            on_clicked do
              self.logged_in = true
            end
          }
          
          button('Logout') {
            enabled <= [self, :logged_in]
            
            on_clicked do
              self.logged_in = false
              self.username = ''
              self.password = ''
            end
          }
        }
      }
    }.show
  end
end

Login.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class Login
  include Glimmer
  
  attr_accessor :username, :password, :logged_in
  
  def logged_out
    !logged_in
  end
  
  def launch
    window('Login') {
      margined true
      
      vertical_box {
        form {
          entry {
            label 'Username:'
            text <=> [self, :username]
            enabled <= [self, :logged_out, computed_by: :logged_in] # computed_by option ensures being notified of changes to logged_in
          }
          
          password_entry {
            label 'Password:'
            text <=> [self, :password]
            enabled <= [self, :logged_out, computed_by: :logged_in]
          }
        }
        
        horizontal_box {
          button('Login') {
            enabled <= [self, :logged_out, computed_by: :logged_in]
            
            on_clicked do
              self.logged_in = true
            end
          }
          
          button('Logout') {
            enabled <= [self, :logged_in]
            
            on_clicked do
              self.logged_in = false
              self.username = ''
              self.password = ''
            end
          }
        }
      }
    }.show
  end
end

Login.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 3 (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class Login
  include Glimmer
  
  attr_accessor :username, :password
  attr_reader :logged_in
  
  def logged_in=(value)
    @logged_in = value
    self.logged_out = !value # calling logged_out= method notifies logged_out observers
  end
  
  def logged_out=(value)
    self.logged_in = !value unless logged_in == !value
  end
  
  def logged_out
    !logged_in
  end
  
  def launch
    window('Login') {
      margined true
      
      vertical_box {
        form {
          entry {
            label 'Username:'
            text <=> [self, :username]
            enabled <= [self, :logged_out]
          }
          
          password_entry {
            label 'Password:'
            text <=> [self, :password]
            enabled <= [self, :logged_out]
          }
        }
        
        horizontal_box {
          button('Login') {
            enabled <= [self, :logged_out]
            
            on_clicked do
              self.logged_in = true
            end
          }
          
          button('Logout') {
            enabled <= [self, :logged_in]
            
            on_clicked do
              self.logged_in = false
              self.username = ''
              self.password = ''
            end
          }
        }
      }
    }.show
  end
end

Login.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 4 (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class Login
  include Glimmer
  
  attr_accessor :username, :password
  attr_reader :logged_in
  
  def logged_in=(value)
    @logged_in = value
    notify_observers(:logged_out) # manually notify observers of logged_out upon logged_in changes; this method comes automatically from enhancement as Glimmer::DataBinding::ObservableModel via data-binding
  end
  
  def logged_out
    !logged_in
  end
  
  def launch
    window('Login') {
      margined true
      
      vertical_box {
        form {
          entry {
            label 'Username:'
            text <=> [self, :username]
            enabled <= [self, :logged_out]
          }
          
          password_entry {
            label 'Password:'
            text <=> [self, :password]
            enabled <= [self, :logged_out]
          }
        }
        
        horizontal_box {
          button('Login') {
            enabled <= [self, :logged_out]
            
            on_clicked do
              self.logged_in = true
            end
          }
          
          button('Logout') {
            enabled <= [self, :logged_in]
            
            on_clicked do
              self.logged_in = false
              self.username = ''
              self.password = ''
            end
          }
        }
      }
    }.show
  end
end

Login.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 5 (without [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Login') {
  margined true
  
  vertical_box {
    form {
      @username_entry = entry {
        label 'Username:'
      }
      
      @password_entry = password_entry {
        label 'Password:'
      }
    }
    
    horizontal_box {
      @login_button = button('Login') {
        on_clicked do
          @username_entry.enabled = false
          @password_entry.enabled = false
          @login_button.enabled = false
          @logout_button.enabled = true
        end
      }
      
      @logout_button = button('Logout') {
        enabled false
        
        on_clicked do
          @username_entry.text = ''
          @password_entry.text = ''
          @username_entry.enabled = true
          @password_entry.enabled = true
          @login_button.enabled = true
          @logout_button.enabled = false
        end
      }
    }
  }
}.show
```

## Method-Based Custom Controls

[Custom keywords](#custom-keywords) can be defined to represent custom controls (components) that provide new features or act as composites of existing controls that need to be reused multiple times in an application or across multiple applications. Custom keywords save a lot of development time, improving productivity and maintainability immensely.
  
This example defines `form_field`, `address_form`, `label_pair`, and `address` as custom controls (keywords).

The custom keywords are defined via methods (thus are "method-based").

[examples/method_based_custom_controls.rb](/examples/method_based_custom_controls.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/method_based_custom_controls.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/method_based_custom_controls'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-method-based-custom-keyword.png](/images/glimmer-dsl-libui-mac-method-based-custom-keyword.png) | ![glimmer-dsl-libui-windows-method-based-custom-keyword.png](/images/glimmer-dsl-libui-windows-method-based-custom-keyword.png) | ![glimmer-dsl-libui-linux-method-based-custom-keyword.png](/images/glimmer-dsl-libui-linux-method-based-custom-keyword.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'
require 'facets'

include Glimmer

Address = Struct.new(:street, :p_o_box, :city, :state, :zip_code)

def form_field(model, attribute)
  attribute = attribute.to_s
  entry { |e|
    label attribute.underscore.split('_').map(&:capitalize).join(' ')
    text <=> [model, attribute]
  }
end

def address_form(address_model)
  form {
    form_field(address_model, :street)
    form_field(address_model, :p_o_box)
    form_field(address_model, :city)
    form_field(address_model, :state)
    form_field(address_model, :zip_code)
  }
end

def label_pair(model, attribute, value)
  horizontal_box {
    label(attribute.to_s.underscore.split('_').map(&:capitalize).join(' '))
    label(value.to_s) {
      text <= [model, attribute]
    }
  }
end

def address_view(address_model)
  vertical_box {
    address_model.each_pair do |attribute, value|
      label_pair(address_model, attribute, value)
    end
  }
end

address1 = Address.new('123 Main St', '23923', 'Denver', 'Colorado', '80014')
address2 = Address.new('2038 Park Ave', '83272', 'Boston', 'Massachusetts', '02101')

window('Method-Based Custom Controls') {
  margined true
  
  horizontal_box {
    vertical_box {
      label('Address 1') {
        stretchy false
      }
      
      address_form(address1)
      
      horizontal_separator {
        stretchy false
      }
      
      label('Address 1 (Saved)') {
        stretchy false
      }
      
      address_view(address1)
    }
    
    vertical_separator {
      stretchy false
    }
    
    vertical_box {
      label('Address 2') {
        stretchy false
      }
      
      address_form(address2)
      
      horizontal_separator {
        stretchy false
      }
      
      label('Address 2 (Saved)') {
        stretchy false
      }
      
      address_view(address2)
    }
  }
}.show
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'
require 'facets'

include Glimmer

Address = Struct.new(:street, :p_o_box, :city, :state, :zip_code)

def form_field(model, property)
  property = property.to_s
  entry { |e|
    label property.underscore.split('_').map(&:capitalize).join(' ')
    text model.send(property).to_s

    on_changed do
      model.send("#{property}=", e.text)
    end
  }
end

def address_form(address_model)
  form {
    form_field(address_model, :street)
    form_field(address_model, :p_o_box)
    form_field(address_model, :city)
    form_field(address_model, :state)
    form_field(address_model, :zip_code)
  }
end

def label_pair(model, attribute, value)
  name_label = nil
  value_label = nil
  horizontal_box {
    name_label = label(attribute.to_s.underscore.split('_').map(&:capitalize).join(' '))
    value_label = label(value.to_s)
  }
  observe(model, attribute) do
    value_label.text = model.send(attribute)
  end
end

def address_view(address_model)
  vertical_box {
    address_model.each_pair do |attribute, value|
      label_pair(address_model, attribute, value)
    end
  }
end

address1 = Address.new('123 Main St', '23923', 'Denver', 'Colorado', '80014')
address2 = Address.new('2038 Park Ave', '83272', 'Boston', 'Massachusetts', '02101')

window('Method-Based Custom Controls') {
  margined true
  
  horizontal_box {
    vertical_box {
      label('Address 1') {
        stretchy false
      }
      
      address_form(address1)
      
      horizontal_separator {
        stretchy false
      }
      
      label('Address 1 (Saved)') {
        stretchy false
      }
      
      address_view(address1)
    }
    
    vertical_separator {
      stretchy false
    }
    
    vertical_box {
      label('Address 2') {
        stretchy false
      }
      
      address_form(address2)
      
      horizontal_separator {
        stretchy false
      }
      
      label('Address 2 (Saved)') {
        stretchy false
      }
      
      address_view(address2)
    }
  }
}.show
```

## Class-Based Custom Controls

[Custom keywords](#custom-keywords) can be defined to represent custom controls (components) that provide new features or act as composites of existing controls that need to be reused multiple times in an application or across multiple applications. Custom keywords save a lot of development time, improving productivity and maintainability immensely.
  
This example defines `form_field`, `address_form`, `label_pair`, and `address` as custom controls (keywords).

The custom keywords are defined via classes that include `Glimmer::LibUI::CustomControl` (thus are "class-based"), thus enabling offloading each custom control into its own file when needed for better code organization.

[examples/class_based_custom_controls.rb](/examples/class_based_custom_controls.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/class_based_custom_controls.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/class_based_custom_controls'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-method-based-custom-keyword.png](/images/glimmer-dsl-libui-mac-method-based-custom-keyword.png) | ![glimmer-dsl-libui-windows-method-based-custom-keyword.png](/images/glimmer-dsl-libui-windows-method-based-custom-keyword.png) | ![glimmer-dsl-libui-linux-method-based-custom-keyword.png](/images/glimmer-dsl-libui-linux-method-based-custom-keyword.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'
require 'facets'

Address = Struct.new(:street, :p_o_box, :city, :state, :zip_code)

class FormField
  include Glimmer::LibUI::CustomControl
  
  options :model, :attribute
  
  body {
    entry { |e|
      label attribute.to_s.underscore.split('_').map(&:capitalize).join(' ')
      text <=> [model, attribute]
    }
  }
end

class AddressForm
  include Glimmer::LibUI::CustomControl
  
  options :address
  
  body {
    form {
      form_field(model: address, attribute: :street)
      form_field(model: address, attribute: :p_o_box)
      form_field(model: address, attribute: :city)
      form_field(model: address, attribute: :state)
      form_field(model: address, attribute: :zip_code)
    }
  }
end

class LabelPair
  include Glimmer::LibUI::CustomControl
  
  options :model, :attribute, :value
  
  body {
    horizontal_box {
      label(attribute.to_s.underscore.split('_').map(&:capitalize).join(' '))
      label(value.to_s) {
        text <= [model, attribute]
      }
    }
  }
end

class AddressView
  include Glimmer::LibUI::CustomControl
  
  options :address
  
  body {
    vertical_box {
      address.each_pair do |attribute, value|
        label_pair(model: address, attribute: attribute, value: value)
      end
    }
  }
end

class ClassBasedCustomControls
  include Glimmer::LibUI::Application # alias: Glimmer::LibUI::CustomWindow
  
  before_body do
    @address1 = Address.new('123 Main St', '23923', 'Denver', 'Colorado', '80014')
    @address2 = Address.new('2038 Park Ave', '83272', 'Boston', 'Massachusetts', '02101')
  end
  
  body {
    window('Class-Based Custom Keyword') {
      margined true
      
      horizontal_box {
        vertical_box {
          label('Address 1') {
            stretchy false
          }
          
          address_form(address: @address1)
          
          horizontal_separator {
            stretchy false
          }
          
          label('Address 1 (Saved)') {
            stretchy false
          }
          
          address_view(address: @address1)
        }
        
        vertical_separator {
          stretchy false
        }
        
        vertical_box {
          label('Address 2') {
            stretchy false
          }
          
          address_form(address: @address2)
          
          horizontal_separator {
            stretchy false
          }
          
          label('Address 2 (Saved)') {
            stretchy false
          }
          
          address_view(address: @address2)
        }
      }
    }
  }
end

ClassBasedCustomControls.launch
```

## Area-Based Custom Controls

[Custom keywords](#custom-keywords) can be defined for graphical custom controls (components) built completely from scratch as vector-graphics on top of the [`area`](#area-api) control while leveraging keyboard and mouse listeners.

This example defines `text_label` and `push_button` as [`area`](#area-api)-based graphical custom controls that can have width, height, font, fill, stroke, border, and custom text location.
      
[examples/area_based_custom_controls.rb](/examples/area_based_custom_controls.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/area_based_custom_controls.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/area_based_custom_controls'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-area-based-custom-controls.png](/images/glimmer-dsl-libui-mac-area-based-custom-controls-text-label.png) ![glimmer-dsl-libui-mac-area-based-custom-controls.png](/images/glimmer-dsl-libui-mac-area-based-custom-controls-push-button.png) ![glimmer-dsl-libui-mac-area-based-custom-controls.png](/images/glimmer-dsl-libui-mac-area-based-custom-controls-push-button-clicked.png) | ![glimmer-dsl-libui-windows-area-based-custom-controls.png](/images/glimmer-dsl-libui-windows-area-based-custom-controls-text-label.png) ![glimmer-dsl-libui-windows-area-based-custom-controls.png](/images/glimmer-dsl-libui-windows-area-based-custom-controls-push-button.png) ![glimmer-dsl-libui-windows-area-based-custom-controls.png](/images/glimmer-dsl-libui-windows-area-based-custom-controls-push-button-clicked.png) | ![glimmer-dsl-libui-linux-area-based-custom-controls.png](/images/glimmer-dsl-libui-linux-area-based-custom-controls-text-label.png) ![glimmer-dsl-libui-linux-area-based-custom-controls.png](/images/glimmer-dsl-libui-linux-area-based-custom-controls-push-button.png) ![glimmer-dsl-libui-linux-area-based-custom-controls.png](/images/glimmer-dsl-libui-linux-area-based-custom-controls-push-button-clicked.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

class AreaBasedCustomControls
  include Glimmer
  
  attr_accessor :label_width, :label_height, :label_font_descriptor,
                :label_text_color, :label_background_fill, :label_border_stroke,
                :label_text_x, :label_text_y,
                :button_width, :button_height, :button_font_descriptor,
                :button_text_color, :button_background_fill, :button_border_stroke,
                :button_text_x, :button_text_y
  
  def initialize
    self.label_width = 335
    self.label_height = 50
    self.label_font_descriptor = {family: OS.linux? ? 'Monospace Bold Italic' : 'Courier New', size: 16, weight: :bold, italic: :italic}
    self.label_text_color = :red
    self.label_background_fill = :yellow
    self.label_border_stroke = :limegreen
    
    self.button_width = 150
    self.button_height = 50
    self.button_font_descriptor = {family: OS.linux? ? 'Monospace Bold Italic' : 'Courier New', size: 36, weight: OS.linux? ? :normal : :bold, italic: :italic}
    self.button_text_color = :green
    self.button_background_fill = :yellow
    self.button_border_stroke = :limegreen
  end
  
  def rebuild_text_label
    @text_label.destroy
    @text_label_vertical_box.content { # re-open vertical box content and shove in a new label
      @text_label = text_label('This is a text label.',
                               width: label_width, height: label_height, font_descriptor: label_font_descriptor,
                               background_fill: label_background_fill, text_color: label_text_color, border_stroke: label_border_stroke,
                               text_x: label_text_x, text_y: label_text_y)
    }
  end
  
  def rebuild_push_button
    @push_button.destroy
    @push_button_vertical_box.content { # re-open vertical box content and shove in a new button
      @push_button = push_button('Push',
                                 width: button_width, height: button_height, font_descriptor: button_font_descriptor,
                                 background_fill: button_background_fill, text_color: button_text_color, border_stroke: button_border_stroke,
                                 text_x: button_text_x, text_y: button_text_y) {
        on_mouse_up do
          message_box('Button Pushed', 'Thank you for pushing the button!')
        end
      }
    }
  end
  
  def launch
    window('Area-Based Custom Controls', 385, 385) { |w|
      margined true
      
      tab {
        tab_item('Text Label') {
          @text_label_vertical_box = vertical_box {
            vertical_box {
              text_label('Text Label Form:', width: 385, height: 30, background_fill: OS.windows? ? :white : {a: 0}, border_stroke: OS.windows? ? :white : {a: 0}, font_descriptor: {size: 16, weight: :bold}, text_x: 0, text_y: OS.windows? ? 0 : 5)

              horizontal_box {
                label('Width')
                spinbox(1, 1000) {
                  value <=> [self, :label_width, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Height')
                spinbox(1, 1000) {
                  value <=> [self, :label_height, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Font')
                font_button {
                  font <=> [self, :label_font_descriptor, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Text Color')
                color_button {
                  color <=> [self, :label_text_color, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Background Color')
                color_button {
                  color <=> [self, :label_background_fill, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Border Color')
                color_button {
                  color <=> [self, :label_border_stroke, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Text X (0=centered)')
                spinbox(0, 1000) {
                  value <=> [self, :label_text_x, on_read: ->(x) {x.nil? ? 0 : x}, on_write: ->(x) {x == 0 ? nil : x}, after_write: method(:rebuild_text_label)]
                }
              }
              
              horizontal_box {
                label('Text Y (0=centered)')
                spinbox(0, 1000) {
                  value <=> [self, :label_text_y, on_read: ->(y) {y.nil? ? 0 : y}, on_write: ->(y) {y == 0 ? nil : y}, after_write: method(:rebuild_text_label)]
                }
              }
            }
            
            @text_label = text_label('This is a text label.',
                                     width: label_width, height: label_height, font_descriptor: label_font_descriptor,
                                     background_fill: label_background_fill, text_color: label_text_color, border_stroke: label_border_stroke,
                                     text_x: label_text_x, text_y: label_text_y)
          }
        }
        
        tab_item('Push Button') {
          @push_button_vertical_box = vertical_box {
            vertical_box {
              text_label('Push Button Form:', width: 385, height: 30, background_fill: OS.windows? ? :white : {a: 0}, border_stroke: OS.windows? ? :white : {a: 0}, font_descriptor: {size: 16, weight: :bold}, text_x: 0, text_y: OS.windows? ? 0 : 5)
              
              horizontal_box {
                label('Width')
                spinbox(1, 1000) {
                  value <=> [self, :button_width, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Height')
                spinbox(1, 1000) {
                  value <=> [self, :button_height, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Font')
                font_button {
                  font <=> [self, :button_font_descriptor, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Text Color')
                color_button {
                  color <=> [self, :button_text_color, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Background Color')
                color_button {
                  color <=> [self, :button_background_fill, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Border Color')
                color_button {
                  color <=> [self, :button_border_stroke, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Text X (0=centered)')
                spinbox(0, 1000) {
                  value <=> [self, :button_text_x, on_read: ->(x) {x.nil? ? 0 : x}, on_write: ->(x) {x == 0 ? nil : x}, after_write: method(:rebuild_push_button)]
                }
              }
              
              horizontal_box {
                label('Text Y (0=centered)')
                spinbox(0, 1000) {
                  value <=> [self, :button_text_y, on_read: ->(y) {y.nil? ? 0 : y}, on_write: ->(y) {y == 0 ? nil : y}, after_write: method(:rebuild_push_button)]
                }
              }
            }
            
            @push_button = push_button('Push',
                                       width: button_width, height: button_height, font_descriptor: button_font_descriptor,
                                       background_fill: button_background_fill, text_color: button_text_color, border_stroke: button_border_stroke,
                                       text_x: button_text_x, text_y: button_text_y) {
              on_mouse_up do
                message_box('Button Pushed', 'Thank you for pushing the button!')
              end
            }
          }
        }
      }
    }.show
  end
    
  # text label (area-based custom control) built with vector graphics on top of area.
  #
  # background_fill is transparent by default.
  # background_fill can accept a single color or gradient stops just as per `fill` property in README.
  # border_stroke is transparent by default.
  # border_stroke can accept thickness and dashes in addition to color just as per `stroke` property in README.
  # text_x and text_y are the offset of the label text in relation to its top-left corner.
  # When text_x, text_y are left nil, the text is automatically centered in the label area.
  # Sometimes, the centering calculation is not perfect due to using a custom font, so
  # in that case, pass in text_x, and text_y manually.
  def text_label(label_text,
                  width: 80, height: 30, font_descriptor: {},
                  background_fill: {a: 0}, text_color: :black, border_stroke: {a: 0},
                  text_x: nil, text_y: nil,
                  &content)
    area { |the_area|
      rectangle(1, 1, width, height) {
        fill background_fill
      }
      rectangle(1, 1, width, height) {
        stroke border_stroke
      }
      
      text_height = (font_descriptor[:size] || 12) * (OS.mac? ? 0.75 : 1.35)
      text_width = (text_height * label_text.size) * (OS.mac? ? 0.75 : 0.60)
      text_x ||= (width - text_width) / 2.0
      text_y ||= (height - 4 - text_height) / 2.0
      text(text_x, text_y, width) {
        string(label_text) {
          color text_color
          font font_descriptor
        }
      }
      
      content&.call(the_area)
    }
  end
  
  # push button (area-based custom control) built with vector graphics on top of area.
  #
  # background_fill is white by default.
  # background_fill can accept a single color or gradient stops just as per `fill` property in README.
  # border_stroke is black by default.
  # border_stroke can accept thickness and dashes in addition to color just as per `stroke` property in README.
  # text_x and text_y are the offset of the button text in relation to its top-left corner.
  # When text_x, text_y are left nil, the text is automatically centered in the button area.
  # Sometimes, the centering calculation is not perfect due to using a custom font, so
  # in that case, pass in text_x, and text_y manually.
  #
  # reuses the text_label custom control
  def push_button(button_text,
                  width: 80, height: 30, font_descriptor: {},
                  background_fill: :white, text_color: :black, border_stroke: {r: 201, g: 201, b: 201},
                  text_x: nil, text_y: nil,
                  &content)
    text_label(button_text,
                  width: width, height: height, font_descriptor: font_descriptor,
                  background_fill: background_fill, text_color: text_color, border_stroke: border_stroke,
                  text_x: text_x, text_y: text_y) { |the_area|
      
      # dig into the_area content and grab elements to modify in mouse listeners below
      background_rectangle = the_area.children[0]
      button_string = the_area.children[2].children[0]
      
      on_mouse_down do
        background_rectangle.fill = {x0: 0, y0: 0, x1: 0, y1: height, stops: [{pos: 0, r: 72, g: 146, b: 247}, {pos: 1, r: 12, g: 85, b: 214}]}
        button_string.color = :white
      end
      
      on_mouse_up do
        background_rectangle.fill = background_fill
        button_string.color = text_color
      end
      
      content&.call(the_area)
    }
  end
end

AreaBasedCustomControls.new.launch
```

## Midi Player

To run this example, install [TiMidity](http://timidity.sourceforge.net) and ensure `timidity` command is in `PATH` (can be installed via [Homebrew](https://brew.sh) on Mac or [apt-get](https://help.ubuntu.com/community/AptGet/Howto) on Linux).

[examples/midi_player.rb](/examples/midi_player.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/midi_player.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/midi_player'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-midi-player.png](/images/glimmer-dsl-libui-mac-midi-player.png) ![glimmer-dsl-libui-mac-midi-player-msg-box.png](/images/glimmer-dsl-libui-mac-midi-player-msg-box.png) | ![glimmer-dsl-libui-windows-midi-player.png](/images/glimmer-dsl-libui-windows-midi-player.png) ![glimmer-dsl-libui-windows-midi-player-msg-box.png](/images/glimmer-dsl-libui-windows-midi-player-msg-box.png) | ![glimmer-dsl-libui-linux-midi-player.png](/images/glimmer-dsl-libui-linux-midi-player.png) ![glimmer-dsl-libui-linux-midi-player-msg-box.png](/images/glimmer-dsl-libui-linux-midi-player-msg-box.png)

[LibUI](https://github.com/kojix2/LibUI) Original Version:

```ruby
require 'libui'
UI = LibUI

class TinyMidiPlayer
  VERSION = '0.0.1'

  def initialize
    UI.init
    @pid = nil
    @music_directory = File.expand_path(ARGV[0] || '~/Music/')
    @midi_files      = Dir.glob(File.join(@music_directory, '**/*.mid'))
                          .sort_by { |path| File.basename(path) }
    at_exit { stop_midi }
    create_gui
  end

  def stop_midi
    if @pid
      Process.kill(:SIGKILL, @pid) if @th.alive?
      @pid = nil
    end
  end

  def play_midi
    stop_midi
    if @pid.nil? && @selected_file
      begin
        @pid = spawn "timidity #{@selected_file}"
        @th = Process.detach @pid
      rescue Errno::ENOENT
        warn 'Timidty++ not found. Please install Timidity++.'
        warn 'https://sourceforge.net/projects/timidity/'
      end
    end
  end

  def show_version(main_window)
    UI.msg_box(main_window,
               'Tiny Midi Player',
               "Written in Ruby\n" \
               "https://github.com/kojix2/libui\n" \
               "Version #{VERSION}")
  end

  def create_gui
    # loop_menu = UI.new_menu('Repeat')
    # items = %w[Off One].map do |item_name|
    #   item = UI.menu_append_check_item(loop_menu, item_name)
    # end
    # items.each_with_index do |item, idx|
    #   UI.menu_item_on_clicked(item) do
    #     @repeat = idx
    #     (items - [item]).each do |i|
    #       UI.menu_item_set_checked(i, 0)
    #     end
    #     0
    #   end
    # end

    help_menu = UI.new_menu('Help')
    version_item = UI.menu_append_item(help_menu, 'Version')

    UI.new_window('Tiny Midi Player', 200, 50, 1).tap do |main_window|
      UI.menu_item_on_clicked(version_item) { show_version(main_window) }

      UI.window_on_closing(main_window) do
        UI.control_destroy(main_window)
        UI.quit
        0
      end

      UI.new_horizontal_box.tap do |hbox|
        UI.new_vertical_box.tap do |vbox|
          UI.new_button('▶').tap do |button1|
            UI.button_on_clicked(button1) { play_midi }
            UI.box_append(vbox, button1, 1)
          end
          UI.new_button('■').tap do |button2|
            UI.button_on_clicked(button2) { stop_midi }
            UI.box_append(vbox, button2, 1)
          end
          UI.box_append(hbox, vbox, 0)
        end
        UI.window_set_child(main_window, hbox)

        UI.new_combobox.tap do |cbox|
          @midi_files.each do |path|
            name = File.basename(path)
            UI.combobox_append(cbox, name)
          end
          UI.combobox_on_selected(cbox) do |ptr|
            @selected_file = @midi_files[UI.combobox_selected(ptr)]
            play_midi if @th&.alive?
            0
          end
          UI.box_append(hbox, cbox, 1)
        end
      end
      UI.control_show(main_window)
    end
    UI.main
    UI.quit
  end
end

TinyMidiPlayer.new
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
# frozen_string_literal: true

require 'glimmer-dsl-libui'

class TinyMidiPlayer
  include Glimmer
  
  VERSION = '0.0.1'
  
  attr_accessor :selected_file

  def initialize
    @pid = nil
    @music_directory = File.expand_path('../sounds', __dir__)
    @midi_files      = Dir.glob(File.join(@music_directory, '**/*.mid'))
                          .sort_by { |path| File.basename(path) }
    at_exit { stop_midi }
    create_gui
  end

  def stop_midi
    if @pid
      Process.kill(:SIGKILL, @pid) if @th.alive?
      @pid = nil
    end
  end

  def play_midi
    stop_midi
    if @pid.nil? && @selected_file
      begin
        @pid = spawn "timidity #{@selected_file}"
        @th = Process.detach @pid
      rescue Errno::ENOENT
        warn 'Timidty++ not found. Please install Timidity++.'
        warn 'https://sourceforge.net/projects/timidity/'
      end
    end
  end

  def show_version
    msg_box('Tiny Midi Player',
              "Written in Ruby\n" \
                "https://github.com/kojix2/libui\n" \
                "Version #{VERSION}")
  end

  def create_gui
    menu('Help') {
      menu_item('Version') {
        on_clicked do
          show_version
        end
      }
    }
    window('Tiny Midi Player', 200, 50) {
      horizontal_box {
        vertical_box {
          stretchy false
          
          button('▶') {
            on_clicked do
              play_midi
            end
          }
          button('■') {
            on_clicked do
              stop_midi
            end
          }
        }

        combobox {
          items @midi_files.map { |path| File.basename(path) }
          # data-bind selected item (String) to self.selected_file with on-read/on-write converters and after_write operation
          selected_item <=> [self, :selected_file, on_read: ->(f) {File.basename(f.to_s)}, on_write: ->(f) {File.join(@music_directory, f)}, after_write: -> { play_midi if @th&.alive? }]
        }
      }
    }.show
  end
end

TinyMidiPlayer.new
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class TinyMidiPlayer
  include Glimmer
  
  VERSION = '0.0.1'
  
  attr_accessor :selected_file

  def initialize
    @pid = nil
    @music_directory = File.expand_path('../sounds', __dir__)
    @midi_files      = Dir.glob(File.join(@music_directory, '**/*.mid'))
                          .sort_by { |path| File.basename(path) }
    at_exit { stop_midi }
    create_gui
  end

  def stop_midi
    if @pid
      Process.kill(:SIGKILL, @pid) if @th.alive?
      @pid = nil
    end
  end

  def play_midi
    stop_midi
    if @pid.nil? && @selected_file
      begin
        @pid = spawn "timidity #{@selected_file}"
        @th = Process.detach @pid
      rescue Errno::ENOENT
        warn 'Timidty++ not found. Please install Timidity++.'
        warn 'https://sourceforge.net/projects/timidity/'
      end
    end
  end

  def show_version
    msg_box('Tiny Midi Player',
              "Written in Ruby\n" \
                "https://github.com/kojix2/libui\n" \
                "Version #{VERSION}")
  end

  def create_gui
    menu('Help') {
      menu_item('Version') {
        on_clicked do
          show_version
        end
      }
    }
    window('Tiny Midi Player', 200, 50) {
      horizontal_box {
        vertical_box {
          stretchy false
          
          button('▶') {
            on_clicked do
              play_midi
            end
          }
          button('■') {
            on_clicked do
              stop_midi
            end
          }
        }

        combobox {
          items @midi_files.map { |path| File.basename(path) }
          # data-bind selected index (Integer) to self.selected_file with on-read/on-write converters and after_write operation
          selected <=> [self, :selected_file, on_read: ->(f) {@midi_files.index(f)}, on_write: ->(i) {@midi_files[i]}, after_write: -> { play_midi if @th&.alive? }]
        }
      }
    }.show
  end
end

TinyMidiPlayer.new
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 3 (without [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class TinyMidiPlayer
  include Glimmer
  
  VERSION = '0.0.1'

  def initialize
    @pid = nil
    @music_directory = File.expand_path('../sounds', __dir__)
    @midi_files      = Dir.glob(File.join(@music_directory, '**/*.mid'))
                          .sort_by { |path| File.basename(path) }
    at_exit { stop_midi }
    create_gui
  end

  def stop_midi
    if @pid
      Process.kill(:SIGKILL, @pid) if @th.alive?
      @pid = nil
    end
  end

  def play_midi
    stop_midi
    if @pid.nil? && @selected_file
      begin
        @pid = spawn "timidity #{@selected_file}"
        @th = Process.detach @pid
      rescue Errno::ENOENT
        warn 'Timidty++ not found. Please install Timidity++.'
        warn 'https://sourceforge.net/projects/timidity/'
      end
    end
  end

  def show_version
    msg_box('Tiny Midi Player',
              "Written in Ruby\n" \
                "https://github.com/kojix2/libui\n" \
                "Version #{VERSION}")
  end

  def create_gui
    menu('Help') {
      menu_item('Version') {
        on_clicked do
          show_version
        end
      }
    }
    window('Tiny Midi Player', 200, 50) {
      horizontal_box {
        vertical_box {
          stretchy false
          
          button('▶') {
            on_clicked do
              play_midi
            end
          }
          button('■') {
            on_clicked do
              stop_midi
            end
          }
        }

        combobox { |c|
          items @midi_files.map { |path| File.basename(path) }
          
          on_selected do
            @selected_file = @midi_files[c.selected]
            play_midi if @th&.alive?
          end
        }
      }
    }.show
  end
end

TinyMidiPlayer.new
```

## Snake

Snake provides an example of building a desktop application [test-first](/spec/examples/snake/model/game_spec.rb) following the MVP ([Model](/examples/snake/model/game.rb) / [View](/examples/snake.rb) / [Presenter](/examples/snake/presenter/grid.rb)) architectural pattern.

Use arrows to move and spacebar to pause/resume.

Note that Snake relies on the new [Ruby Pattern Matching feature](https://docs.ruby-lang.org/en/3.0/doc/syntax/pattern_matching_rdoc.html) available starting in Ruby 2.7 experimentally and in Ruby 3.0 officially.

[examples/snake.rb](/examples/snake.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/snake.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/snake'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-snake.png](/images/glimmer-dsl-libui-mac-snake.png) ![glimmer-dsl-libui-mac-snake-game-over.png](/images/glimmer-dsl-libui-mac-snake-game-over.png) | ![glimmer-dsl-libui-windows-snake.png](/images/glimmer-dsl-libui-windows-snake.png) ![glimmer-dsl-libui-windows-snake-game-over.png](/images/glimmer-dsl-libui-windows-snake-game-over.png) | ![glimmer-dsl-libui-linux-snake.png](/images/glimmer-dsl-libui-linux-snake.png) ![glimmer-dsl-libui-linux-snake-game-over.png](/images/glimmer-dsl-libui-linux-snake-game-over.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

require_relative 'snake/presenter/grid'

class Snake
  include Glimmer
  
  CELL_SIZE = 15
  SNAKE_MOVE_DELAY = 0.1
  
  def initialize
    @game = Model::Game.new
    @grid = Presenter::Grid.new(@game)
    @game.start
    @keypress_queue = []
    create_gui
    register_observers
  end
  
  def launch
    @main_window.show
  end
  
  def register_observers
    observe(@game, :over) do |game_over|
      Glimmer::LibUI.queue_main do
        if game_over
          msg_box('Game Over!', "Score: #{@game.score} | High Score: #{@game.high_score}")
          @game.start
        end
      end
    end
    
    Glimmer::LibUI.timer(SNAKE_MOVE_DELAY) do
      unless @game.paused? || @game.over?
        process_queued_keypress
        @game.snake.move
      end
    end
  end
  
  def process_queued_keypress
    # key press queue ensures one turn per snake move to avoid a double-turn resulting in instant death (due to snake illogically going back against itself)
    key = @keypress_queue.shift
    case [@game.snake.head.orientation, key]
    in [:north, :right] | [:east, :down] | [:south, :left] | [:west, :up]
      @game.snake.turn_right
    in [:north, :left] | [:west, :down] | [:south, :right] | [:east, :up]
      @game.snake.turn_left
    else
      # No Op
    end
  end
  
  def create_gui
    @main_window = window {
      # data-bind window title to game score, converting it to a title string on read from the model
      title <= [@game, :score, on_read: -> (score) {"Snake (Score: #{@game.score})"}]
      content_size @game.width * CELL_SIZE, @game.height * CELL_SIZE
      resizable false
      
      vertical_box {
        padded false
        
        @game.height.times do |row|
          horizontal_box {
            padded false
            
            @game.width.times do |column|
              area {
                square(0, 0, CELL_SIZE) {
                  fill <= [@grid.cells[row][column], :color] # data-bind square fill to grid cell color
                }
                
                on_key_up do |area_key_event|
                  if area_key_event[:key] == ' '
                    @game.toggle_pause
                  else
                    @keypress_queue << area_key_event[:ext_key]
                  end
                end
              }
            end
          }
        end
      }
    }
  end
end

Snake.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

require_relative 'snake/presenter/grid'

class Snake
  include Glimmer
  
  CELL_SIZE = 15
  SNAKE_MOVE_DELAY = 0.1
  
  def initialize
    @game = Model::Game.new
    @grid = Presenter::Grid.new(@game)
    @game.start
    @keypress_queue = []
    create_gui
    register_observers
  end
  
  def launch
    @main_window.show
  end
  
  def register_observers
    @game.height.times do |row|
      @game.width.times do |column|
        observe(@grid.cells[row][column], :color) do |new_color|
          @cell_grid[row][column].fill = new_color
        end
      end
    end
    
    observe(@game, :over) do |game_over|
      Glimmer::LibUI.queue_main do
        if game_over
          msg_box('Game Over!', "Score: #{@game.score} | High Score: #{@game.high_score}")
          @game.start
        end
      end
    end
    
    Glimmer::LibUI.timer(SNAKE_MOVE_DELAY) do
      unless @game.paused? || @game.over?
        process_queued_keypress
        @game.snake.move
      end
    end
  end
  
  def process_queued_keypress
    # key press queue ensures one turn per snake move to avoid a double-turn resulting in instant death (due to snake illogically going back against itself)
    key = @keypress_queue.shift
    case [@game.snake.head.orientation, key]
    in [:north, :right] | [:east, :down] | [:south, :left] | [:west, :up]
      @game.snake.turn_right
    in [:north, :left] | [:west, :down] | [:south, :right] | [:east, :up]
      @game.snake.turn_left
    else
      # No Op
    end
  end
  
  def create_gui
    @cell_grid = []
    @main_window = window {
      # data-bind window title to game score, converting it to a title string on read from the model
      title <= [@game, :score, on_read: -> (score) {"Snake (Score: #{@game.score})"}]
      content_size @game.width * CELL_SIZE, @game.height * CELL_SIZE
      resizable false
      
      vertical_box {
        padded false
        
        @game.height.times do |row|
          @cell_grid << []
          horizontal_box {
            padded false
            
            @game.width.times do |column|
              area {
                @cell_grid.last << square(0, 0, CELL_SIZE) {
                  fill Presenter::Cell::COLOR_CLEAR
                }
                
                on_key_up do |area_key_event|
                  if area_key_event[:key] == ' '
                    @game.toggle_pause
                  else
                    @keypress_queue << area_key_event[:ext_key]
                  end
                end
              }
            end
          }
        end
      }
    }
  end
end

Snake.new.launch
```

## Tetris

Glimmer Tetris utilizes many small areas to represent Tetromino blocks because this ensures smaller redraws per tetromino block color change, thus achieving higher performance than redrawing one large area on every little change.

Note that Tetris relies on the new [Ruby Pattern Matching feature](https://docs.ruby-lang.org/en/3.0/doc/syntax/pattern_matching_rdoc.html) available starting in Ruby 2.7 experimentally and in Ruby 3.0 officially.

[examples/tetris.rb](/examples/tetris.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/tetris.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/tetris'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-tetris.png](/images/glimmer-dsl-libui-mac-tetris.png) | ![glimmer-dsl-libui-windows-tetris.png](/images/glimmer-dsl-libui-windows-tetris.png) | ![glimmer-dsl-libui-linux-tetris.png](/images/glimmer-dsl-libui-linux-tetris.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

require_relative 'tetris/model/game'

class Tetris
  include Glimmer
  
  BLOCK_SIZE = 25
  BEVEL_CONSTANT = 20
  COLOR_GRAY = {r: 192, g: 192, b: 192}
    
  def initialize
    @game = Model::Game.new
  end
  
  def launch
    create_gui
    register_observers
    @game.start!
    @main_window.show
  end
  
  def create_gui
    menu_bar
    
    @main_window = window('Glimmer Tetris') {
      content_size Model::Game::PLAYFIELD_WIDTH * BLOCK_SIZE, Model::Game::PLAYFIELD_HEIGHT * BLOCK_SIZE + 98
      resizable false
      
      vertical_box {
        label { # filler
          stretchy false
        }
        
        score_board(block_size: BLOCK_SIZE) {
          stretchy false
        }
        
        @playfield_blocks = playfield(playfield_width: Model::Game::PLAYFIELD_WIDTH, playfield_height: Model::Game::PLAYFIELD_HEIGHT, block_size: BLOCK_SIZE)
      }
    }
  end
  
  def register_observers
    observe(@game, :game_over) do |game_over|
      if game_over
        @pause_menu_item.enabled = false
        show_game_over_dialog
      else
        @pause_menu_item.enabled = true
        start_moving_tetrominos_down
      end
    end
    
    Model::Game::PLAYFIELD_HEIGHT.times do |row|
      Model::Game::PLAYFIELD_WIDTH.times do |column|
        observe(@game.playfield[row][column], :color) do |new_color|
          Glimmer::LibUI.queue_main do
            color = Glimmer::LibUI.interpret_color(new_color)
            block = @playfield_blocks[row][column]
            block[:background_square].fill = color
            block[:top_bevel_edge].fill = {r: color[:r] + 4*BEVEL_CONSTANT, g: color[:g] + 4*BEVEL_CONSTANT, b: color[:b] + 4*BEVEL_CONSTANT}
            block[:right_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
            block[:bottom_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
            block[:left_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
            block[:border_square].stroke = new_color == Model::Block::COLOR_CLEAR ? COLOR_GRAY : color
          end
        end
      end
    end
    
    Model::Game::PREVIEW_PLAYFIELD_HEIGHT.times do |row|
      Model::Game::PREVIEW_PLAYFIELD_WIDTH.times do |column|
        preview_updater = proc do
          Glimmer::LibUI.queue_main do
            new_color = @game.preview_playfield[row][column].color
            color = Glimmer::LibUI.interpret_color(new_color)
            block = @preview_playfield_blocks[row][column]
            if @game.show_preview_tetromino?
              block[:background_square].fill = color
              block[:top_bevel_edge].fill = {r: color[:r] + 4*BEVEL_CONSTANT, g: color[:g] + 4*BEVEL_CONSTANT, b: color[:b] + 4*BEVEL_CONSTANT}
              block[:right_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
              block[:bottom_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
              block[:left_bevel_edge].fill = {r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT}
              block[:border_square].stroke = new_color == Model::Block::COLOR_CLEAR ? COLOR_GRAY : color
            else
              transparent_color = {r: 255, g: 255, b: 255, a: 0}
              block[:background_square].fill = transparent_color
              block[:top_bevel_edge].fill = transparent_color
              block[:right_bevel_edge].fill = transparent_color
              block[:bottom_bevel_edge].fill = transparent_color
              block[:left_bevel_edge].fill = transparent_color
              block[:border_square].stroke = transparent_color
            end
          end
        end
        observe(@game.preview_playfield[row][column], :color, &preview_updater)
        observe(@game, :show_preview_tetromino, &preview_updater)
      end
    end

    observe(@game, :score) do |new_score|
      Glimmer::LibUI.queue_main do
        @score_label.text = new_score.to_s
      end
    end

    observe(@game, :lines) do |new_lines|
      Glimmer::LibUI.queue_main do
        @lines_label.text = new_lines.to_s
      end
    end

    observe(@game, :level) do |new_level|
      Glimmer::LibUI.queue_main do
        @level_label.text = new_level.to_s
      end
    end
  end
  
  def menu_bar
    menu('Game') {
      @pause_menu_item = check_menu_item('Pause') {
        enabled false
        checked <=> [@game, :paused]
      }
      
      menu_item('Restart') {
        on_clicked do
          @game.restart!
        end
      }
      
      separator_menu_item
      
      menu_item('Exit') {
        on_clicked do
          exit(0)
        end
      }
      
      quit_menu_item if OS.mac?
    }
    
    menu('View') {
      check_menu_item('Show Next Block Preview') {
        checked <=> [@game, :show_preview_tetromino]
      }
      
      separator_menu_item
      
      menu_item('Show High Scores') {
        on_clicked do
          show_high_scores
        end
      }
      
      menu_item('Clear High Scores') {
        on_clicked {
          @game.clear_high_scores!
        }
      }
      
      separator_menu_item
    }

    menu('Options') {
      radio_menu_item('Instant Down on Up Arrow') {
        checked <=> [@game, :instant_down_on_up]
      }
      
      radio_menu_item('Rotate Right on Up Arrow') {
        checked <=> [@game, :rotate_right_on_up]
      }
      
      radio_menu_item('Rotate Left on Up Arrow') {
        checked <=> [@game, :rotate_left_on_up]
      }
    }

    menu('Help') {
      if OS.mac?
        about_menu_item {
          on_clicked do
            show_about_dialog
          end
        }
      end
      
      menu_item('About') {
        on_clicked do
          show_about_dialog
        end
      }
    }
  end
  
  def playfield(playfield_width: , playfield_height: , block_size: , &extra_content)
    blocks = []
    vertical_box {
      padded false
      
      playfield_height.times.map do |row|
        blocks << []
        horizontal_box {
          padded false
          
          playfield_width.times.map do |column|
            blocks.last << block(row: row, column: column, block_size: block_size)
          end
        }
      end
      
      extra_content&.call
    }
    blocks
  end
  
  def block(row: , column: , block_size: , &extra_content)
    block = {}
    bevel_pixel_size = 0.16 * block_size.to_f
    color = Glimmer::LibUI.interpret_color(Model::Block::COLOR_CLEAR)
    block[:area] = area {
      block[:background_square] = square(0, 0, block_size) {
        fill color
      }
      
      block[:top_bevel_edge] = polygon {
        point_array 0, 0, block_size, 0, block_size - bevel_pixel_size, bevel_pixel_size, bevel_pixel_size, bevel_pixel_size
        fill r: color[:r] + 4*BEVEL_CONSTANT, g: color[:g] + 4*BEVEL_CONSTANT, b: color[:b] + 4*BEVEL_CONSTANT
      }
      
      block[:right_bevel_edge] = polygon {
        point_array block_size, 0, block_size - bevel_pixel_size, bevel_pixel_size, block_size - bevel_pixel_size, block_size - bevel_pixel_size, block_size, block_size
        fill r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT
      }
      
      block[:bottom_bevel_edge] = polygon {
        point_array block_size, block_size, 0, block_size, bevel_pixel_size, block_size - bevel_pixel_size, block_size - bevel_pixel_size, block_size - bevel_pixel_size
        fill r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT
      }
      
      block[:left_bevel_edge] = polygon {
        point_array 0, 0, 0, block_size, bevel_pixel_size, block_size - bevel_pixel_size, bevel_pixel_size, bevel_pixel_size
        fill r: color[:r] - BEVEL_CONSTANT, g: color[:g] - BEVEL_CONSTANT, b: color[:b] - BEVEL_CONSTANT
      }
      
      block[:border_square] = square(0, 0, block_size) {
        stroke COLOR_GRAY
      }
      
      on_key_down do |key_event|
        case key_event
        in ext_key: :down
          if OS.windows?
            # rate limit downs in Windows as they go too fast when key is held
            @queued_downs ||= 0
            if @queued_downs < 2
              @queued_downs += 1
              Glimmer::LibUI.timer(0.01, repeat: false) do
                @game.down! if @queued_downs < 2
                @queued_downs -= 1
              end
            end
          else
            @game.down!
          end
        in key: ' '
          @game.down!(instant: true)
        in ext_key: :up
          case @game.up_arrow_action
          when :instant_down
            @game.down!(instant: true)
          when :rotate_right
            @game.rotate!(:right)
          when :rotate_left
            @game.rotate!(:left)
          end
        in ext_key: :left
          @game.left!
        in ext_key: :right
          @game.right!
        in modifier: :shift
          @game.rotate!(:right)
        in modifier: :control
          @game.rotate!(:left)
        else
          # Do Nothing
        end
      end
      
      extra_content&.call
    }
    block
  end
  
  def score_board(block_size: , &extra_content)
    vertical_box {
      horizontal_box {
        label # filler
        grid {
          stretchy false
          
          label('Score') {
            left 0
            top 0
            halign :fill
          }
          @score_label = label {
            left 0
            top 1
            halign :center
          }
    
          label('Lines') {
            left 1
            top 0
            halign :fill
          }
          @lines_label = label {
            left 1
            top 1
            halign :center
          }
    
          label('Level') {
            left 2
            top 0
            halign :fill
          }
          @level_label = label {
            left 2
            top 1
            halign :center
          }
        }
        label # filler
      }
      
      horizontal_box {
        label # filler
        @preview_playfield_blocks = playfield(playfield_width: Model::Game::PREVIEW_PLAYFIELD_WIDTH, playfield_height: Model::Game::PREVIEW_PLAYFIELD_HEIGHT, block_size: block_size)
        label # filler
      }
    
      extra_content&.call
    }
  end
  
  def start_moving_tetrominos_down
    unless @tetrominos_start_moving_down
      @tetrominos_start_moving_down = true
      Glimmer::LibUI.timer(@game.delay) do
        @game.down! if !@game.game_over? && !@game.paused?
      end
    end
  end
  
  def show_game_over_dialog
    Glimmer::LibUI.queue_main do
      msg_box('Game Over!', "Score: #{@game.high_scores.first.score}\nLines: #{@game.high_scores.first.lines}\nLevel: #{@game.high_scores.first.level}")
      @game.restart!
    end
  end
  
  def show_high_scores
    Glimmer::LibUI.queue_main do
      game_paused = !!@game.paused
      @game.paused = true
      if @game.high_scores.empty?
        high_scores_string = "No games have been scored yet."
      else
        high_scores_string = @game.high_scores.map do |high_score|
          "#{high_score.name} | Score: #{high_score.score} | Lines: #{high_score.lines} | Level: #{high_score.level}"
        end.join("\n")
      end
      msg_box('High Scores', high_scores_string)
      @game.paused = game_paused
    end
  end
  
  def show_about_dialog
    Glimmer::LibUI.queue_main do
      msg_box('About', 'Glimmer Tetris - Glimmer DSL for LibUI Example - Copyright (c) 2021-2022 Andy Maleh')
    end
  end
end

Tetris.new.launch
```

## Tic Tac Toe

[examples/tic_tac_toe.rb](/examples/tic_tac_toe.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/tic_tac_toe.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/tic_tac_toe'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-tic-tac-toe.png](/images/glimmer-dsl-libui-mac-tic-tac-toe.png) ![glimmer-dsl-libui-mac-tic-tac-toe-player-o-wins.png](/images/glimmer-dsl-libui-mac-tic-tac-toe-player-o-wins.png) ![glimmer-dsl-libui-mac-tic-tac-toe-player-x-wins.png](/images/glimmer-dsl-libui-mac-tic-tac-toe-player-x-wins.png) ![glimmer-dsl-libui-mac-tic-tac-toe-draw.png](/images/glimmer-dsl-libui-mac-tic-tac-toe-draw.png) | ![glimmer-dsl-libui-windows-tic-tac-toe.png](/images/glimmer-dsl-libui-windows-tic-tac-toe.png) ![glimmer-dsl-libui-windows-tic-tac-toe-player-o-wins.png](/images/glimmer-dsl-libui-windows-tic-tac-toe-player-o-wins.png) ![glimmer-dsl-libui-windows-tic-tac-toe-player-x-wins.png](/images/glimmer-dsl-libui-windows-tic-tac-toe-player-x-wins.png) ![glimmer-dsl-libui-windows-tic-tac-toe-draw.png](/images/glimmer-dsl-libui-windows-tic-tac-toe-draw.png) | ![glimmer-dsl-libui-linux-tic-tac-toe.png](/images/glimmer-dsl-libui-linux-tic-tac-toe.png) ![glimmer-dsl-libui-linux-tic-tac-toe-player-o-wins.png](/images/glimmer-dsl-libui-linux-tic-tac-toe-player-o-wins.png) ![glimmer-dsl-libui-linux-tic-tac-toe-player-x-wins.png](/images/glimmer-dsl-libui-linux-tic-tac-toe-player-x-wins.png) ![glimmer-dsl-libui-linux-tic-tac-toe-draw.png](/images/glimmer-dsl-libui-linux-tic-tac-toe-draw.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

require_relative "tic_tac_toe/board"

class TicTacToe
  include Glimmer

  def initialize
    @tic_tac_toe_board = Board.new
  end
  
  def launch
    create_gui
    register_observers
    @main_window.show
  end
  
  def register_observers
    observe(@tic_tac_toe_board, :game_status) do |game_status|
      display_win_message if game_status == Board::WIN
      display_draw_message if game_status == Board::DRAW
    end
  end

  def create_gui
    @main_window = window('Tic-Tac-Toe', 180, 180) {
      resizable false
      
      vertical_box {
        padded false
        
        3.times.map do |row|
          horizontal_box {
            padded false
            
            3.times.map do |column|
              area {
                square(0, 0, 60) {
                  stroke :black, thickness: 2
                }
                text(23, 19) {
                  string {
                    font family: 'Arial', size: OS.mac? ? 20 : 16
                    # data-bind string property of area text attributed string to tic tac toe board cell sign
                    string <= [@tic_tac_toe_board[row + 1, column + 1], :sign] # board model is 1-based
                  }
                }
                on_mouse_up do
                  @tic_tac_toe_board.mark(row + 1, column + 1) # board model is 1-based
                end
              }
            end
          }
        end
      }
    }
  end

  def display_win_message
    display_game_over_message("Player #{@tic_tac_toe_board.winning_sign} has won!")
  end

  def display_draw_message
    display_game_over_message("Draw!")
  end

  def display_game_over_message(message_text)
    Glimmer::LibUI.queue_main do
      msg_box('Game Over', message_text)
      @tic_tac_toe_board.reset!
    end
  end
end

TicTacToe.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby

require 'glimmer-dsl-libui'

require_relative "tic_tac_toe/board"

class TicTacToe
  include Glimmer

  def initialize
    @tic_tac_toe_board = Board.new
  end
  
  def launch
    create_gui
    register_observers
    @main_window.show
  end
  
  def register_observers
    observe(@tic_tac_toe_board, :game_status) do |game_status|
      display_win_message if game_status == Board::WIN
      display_draw_message if game_status == Board::DRAW
    end
    
    3.times.map do |row|
      3.times.map do |column|
        observe(@tic_tac_toe_board[row + 1, column + 1], :sign) do |sign| # board model is 1-based
          @cells[row][column].string = sign
        end
      end
    end
  end
  
  def create_gui
    @main_window = window('Tic-Tac-Toe', 180, 180) {
      resizable false
      
      @cells = []
      vertical_box {
        padded false
        
        3.times.map do |row|
          @cells << []
          horizontal_box {
            padded false
            
            3.times.map do |column|
              area {
                square(0, 0, 60) {
                  stroke :black, thickness: 2
                }
                text(23, 19) {
                  @cells[row] << string('') {
                    font family: 'Arial', size: OS.mac? ? 20 : 16
                  }
                }
                on_mouse_up do
                  @tic_tac_toe_board.mark(row + 1, column + 1) # board model is 1-based
                end
              }
            end
          }
        end
      }
    }
  end

  def display_win_message
    display_game_over_message("Player #{@tic_tac_toe_board.winning_sign} has won!")
  end

  def display_draw_message
    display_game_over_message("Draw!")
  end

  def display_game_over_message(message_text)
    Glimmer::LibUI.queue_main do
      msg_box('Game Over', message_text)
      @tic_tac_toe_board.reset!
    end
  end
end

TicTacToe.new.launch
```

## Timer

To run this example, install [TiMidity](http://timidity.sourceforge.net) and ensure `timidity` command is in `PATH` (can be installed via [Homebrew](https://brew.sh) on Mac or [apt-get](https://help.ubuntu.com/community/AptGet/Howto) on Linux).

[examples/timer.rb](/examples/timer.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/timer.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/timer'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-timer.png](/images/glimmer-dsl-libui-mac-timer.png) ![glimmer-dsl-libui-mac-timer-in-progress.png](/images/glimmer-dsl-libui-mac-timer-in-progress.png) | ![glimmer-dsl-libui-windows-timer.png](/images/glimmer-dsl-libui-windows-timer.png) ![glimmer-dsl-libui-windows-timer-in-progress.png](/images/glimmer-dsl-libui-windows-timer-in-progress.png) | ![glimmer-dsl-libui-linux-timer.png](/images/glimmer-dsl-libui-linux-timer.png) ![glimmer-dsl-libui-linux-timer-in-progress.png](/images/glimmer-dsl-libui-linux-timer-in-progress.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class Timer
  include Glimmer
  
  SECOND_MAX = 59
  MINUTE_MAX = 59
  HOUR_MAX = 23
  
  attr_accessor :hour, :min, :sec, :started, :played
  
  def initialize
    @pid = nil
    @alarm_file = File.expand_path('../sounds/AlanWalker-Faded.mid', __dir__)
    @hour = @min = @sec = 0
    at_exit { stop_alarm }
    setup_timer
    create_gui
  end

  def stop_alarm
    if @pid
      Process.kill(:SIGKILL, @pid) if @th.alive?
      @pid = nil
    end
  end

  def play_alarm
    stop_alarm
    if @pid.nil?
      begin
        @pid = spawn "timidity -G 0.0-10.0 #{@alarm_file}"
        @th = Process.detach @pid
      rescue Errno::ENOENT
        warn 'Timidty++ not found. Please install Timidity++.'
        warn 'https://sourceforge.net/projects/timidity/'
      end
    end
  end

  def setup_timer
    unless @setup_timer
      Glimmer::LibUI.timer(1) do
        if @started
          seconds = @sec
          minutes = @min
          hours = @hour
          if seconds > 0
            self.sec = seconds -= 1
          end
          if seconds == 0
            if minutes > 0
              self.min = minutes -= 1
              self.sec = seconds = SECOND_MAX
            end
            if minutes == 0
              if hours > 0
                self.hour = hours -= 1
                self.min = minutes = MINUTE_MAX
                self.sec = seconds = SECOND_MAX
              end
              if hours == 0 && minutes == 0 && seconds == 0
                self.started = false
                unless @played
                  play_alarm
                  msg_box('Alarm', 'Countdown Is Finished!')
                  self.played = true
                end
              end
            end
          end
        end
      end
      @setup_timer = true
    end
  end

  def create_gui
    window('Timer') {
      margined true
      
      group('Countdown') {
        vertical_box {
          horizontal_box {
            spinbox(0, HOUR_MAX) {
              stretchy false
              value <=> [self, :hour]
            }
            label(':') {
              stretchy false
            }
            spinbox(0, MINUTE_MAX) {
              stretchy false
              value <=> [self, :min]
            }
            label(':') {
              stretchy false
            }
            spinbox(0, SECOND_MAX) {
              stretchy false
              value <=> [self, :sec]
            }
          }
          horizontal_box {
            button('Start') {
              enabled <= [self, :started, on_read: :!]
              
              on_clicked do
                self.started = true
                self.played = false
              end
            }
            
            button('Stop') {
              enabled <= [self, :started]
              
              on_clicked do
                self.started = false
              end
            }
          }
        }
      }
    }.show
  end
end

Timer.new
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class Timer
  include Glimmer
  
  SECOND_MAX = 59
  MINUTE_MAX = 59
  HOUR_MAX = 23
  
  def initialize
    @pid = nil
    @alarm_file = File.expand_path('../sounds/AlanWalker-Faded.mid', __dir__)
    at_exit { stop_alarm }
    setup_timer
    create_gui
  end

  def stop_alarm
    if @pid
      Process.kill(:SIGKILL, @pid) if @th.alive?
      @pid = nil
    end
  end

  def play_alarm
    stop_alarm
    if @pid.nil?
      begin
        @pid = spawn "timidity -G 0.0-10.0 #{@alarm_file}"
        @th = Process.detach @pid
      rescue Errno::ENOENT
        warn 'Timidty++ not found. Please install Timidity++.'
        warn 'https://sourceforge.net/projects/timidity/'
      end
    end
  end

  def setup_timer
    unless @setup_timer
      Glimmer::LibUI.timer(1) do
        if @started
          seconds = @sec_spinbox.value
          minutes = @min_spinbox.value
          hours = @hour_spinbox.value
          if seconds > 0
            @sec_spinbox.value = seconds -= 1
          end
          if seconds == 0
            if minutes > 0
              @min_spinbox.value = minutes -= 1
              @sec_spinbox.value = seconds = SECOND_MAX
            end
            if minutes == 0
              if hours > 0
                @hour_spinbox.value = hours -= 1
                @min_spinbox.value = minutes = MINUTE_MAX
                @sec_spinbox.value = seconds = SECOND_MAX
              end
              if hours == 0 && minutes == 0 && seconds == 0
                @start_button.enabled = true
                @stop_button.enabled = false
                @started = false
                unless @played
                  play_alarm
                  msg_box('Alarm', 'Countdown Is Finished!')
                  @played = true
                end
              end
            end
          end
        end
      end
      @setup_timer = true
    end
  end

  def create_gui
    window('Timer') {
      margined true
      
      group('Countdown') {
        vertical_box {
          horizontal_box {
            @hour_spinbox = spinbox(0, HOUR_MAX) {
              stretchy false
              value 0
            }
            label(':') {
              stretchy false
            }
            @min_spinbox = spinbox(0, MINUTE_MAX) {
              stretchy false
              value 0
            }
            label(':') {
              stretchy false
            }
            @sec_spinbox = spinbox(0, SECOND_MAX) {
              stretchy false
              value 0
            }
          }
          horizontal_box {
            @start_button = button('Start') {
              on_clicked do
                @start_button.enabled = false
                @stop_button.enabled = true
                @started = true
                @played = false
              end
            }
            
            @stop_button = button('Stop') {
              enabled false
              
              on_clicked do
                @start_button.enabled = true
                @stop_button.enabled = false
                @started = false
              end
            }
          }
        }
      }
    }.show
  end
end

Timer.new
```

## Shape Coloring

This example demonstrates being able to nest listeners within shapes directly, and [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) will automatically detect when the mouse lands inside the shapes to notify listeners.

This example also demonstrates very basic drag and drop support, implemented manually with shape listeners.

[examples/shape_coloring.rb](/examples/shape_coloring.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/shape_coloring.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/shape_coloring'"
```

Shape Coloring Example

![glimmer-dsl-libui-mac-shape-coloring.png](/images/glimmer-dsl-libui-mac-shape-coloring.png)

![glimmer-dsl-libui-mac-shape-coloring-drag-and-drop.png](/images/glimmer-dsl-libui-mac-shape-coloring-drag-and-drop.png)

![glimmer-dsl-libui-mac-shape-coloring-color-dialog.png](/images/glimmer-dsl-libui-mac-shape-coloring-color-dialog.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

class ShapeColoring
  include Glimmer::LibUI::Application
  
  COLOR_SELECTION = Glimmer::LibUI.interpret_color(:red)
  
  before_body {
    @shapes = []
  }
  
  body {
    window('Shape Coloring', 200, 220) {
      margined false
      
      grid {
        label("Drag & drop shapes to move or\nclick a shape to select and\nchange color via color button") {
          left 0
          top 0
          hexpand true
          halign :center
          vexpand false
        }
        
        color_button { |cb|
          left 0
          top 1
          hexpand true
          vexpand false
          
          on_changed do
            @selected_shape&.fill = cb.color
          end
        }
      
        area {
          left 0
          top 2
          hexpand true
          vexpand true
          
          rectangle(0, 0, 600, 400) { # background shape
            fill :white
          }
          
          @shapes << colorable(:rectangle, 20, 20, 40, 20) {
            fill :lime
          }
          
          @shapes << colorable(:square, 80, 20, 20) {
            fill :blue
          }
          
          @shapes << colorable(:circle, 75, 70, 20) {
            fill :green
          }
          
          @shapes << colorable(:arc, 120, 70, 40, 0, 145) {
            fill :orange
          }
          
          @shapes << colorable(:polygon, 120, 10, 120, 50, 150, 10, 150, 50) {
            fill :cyan
          }
          
          @shapes << colorable(:polybezier, 20, 40,
                     30, 100, 50, 80, 80, 110,
                     40, 120, 20, 120, 30, 91) {
            fill :pink
          }
          
          on_mouse_dragged do |area_mouse_event|
            mouse_dragged(area_mouse_event)
          end
          
          on_mouse_dropped do |area_mouse_event|
            mouse_dropped(area_mouse_event)
          end
        }
      }
    }
  }
  
  def colorable(shape_symbol, *args, &content)
    send(shape_symbol, *args) do |shape|
      on_mouse_up do |area_mouse_event|
        unless @dragged_shape
          old_stroke = Glimmer::LibUI.interpret_color(shape.stroke).slice(:r, :g, :b)
          @shapes.each {|sh| sh.stroke = nil}
          @selected_shape = nil
          unless old_stroke == COLOR_SELECTION
            shape.stroke = COLOR_SELECTION.merge(thickness: 2)
            @selected_shape = shape
          end
        end
      end
      
      on_mouse_drag_started do |area_mouse_event|
        mouse_drag_started(shape, area_mouse_event)
      end
      
      on_mouse_dragged do |area_mouse_event|
        mouse_dragged(area_mouse_event)
      end
      
      on_mouse_dropped do |area_mouse_event|
        mouse_dropped(area_mouse_event)
      end
      
      content.call(shape)
    end
  end
  
  def mouse_drag_started(dragged_shape, area_mouse_event)
    @dragged_shape = dragged_shape
    @dragged_shape_x = area_mouse_event[:x]
    @dragged_shape_y = area_mouse_event[:y]
  end
  
  def mouse_dragged(area_mouse_event)
    if @dragged_shape && @dragged_shape_x && @dragged_shape_y
      x_delta = area_mouse_event[:x] - @dragged_shape_x
      y_delta = area_mouse_event[:y] - @dragged_shape_y
      @dragged_shape.move_by(x_delta, y_delta)
      @dragged_shape_x = area_mouse_event[:x]
      @dragged_shape_y = area_mouse_event[:y]
    end
  end
  
  def mouse_dropped(area_mouse_event)
    @dragged_shape = nil
    @dragged_shape_x = nil
    @dragged_shape_y = nil
  end
end

ShapeColoring.launch
```
