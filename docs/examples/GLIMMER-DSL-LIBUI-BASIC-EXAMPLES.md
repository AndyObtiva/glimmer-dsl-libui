# Glimmer DSL for LibUI Basic Examples

- [Glimmer DSL for LibUI Basic Examples](#glimmer-dsl-for-libui-basic-examples)
  - [Basic Window](#basic-window)
  - [Basic Child Window](#basic-child-window)
  - [Basic Button](#basic-button)
  - [Basic Entry](#basic-entry)
  - [Simple Notepad](#simple-notepad)
  - [Font Button](#font-button)
  - [Color Button](#color-button)
  - [Date Time Picker](#date-time-picker)
  - [Form](#form)
  - [Basic Table](#basic-table)
  - [Basic Table Image](#basic-table-image)
  - [Basic Table Image Text](#basic-table-image-text)
  - [Basic Table Button](#basic-table-button)
  - [Basic Table Checkbox](#basic-table-checkbox)
  - [Basic Table Checkbox Text](#basic-table-checkbox-text)
  - [Basic Table Progress Bar](#basic-table-progress-bar)
  - [Basic Table Color](#basic-table-color)
  - [Basic Table Selection](#basic-table-selection)
  - [Basic Area](#basic-area)
  - [Basic Scrolling Area](#basic-scrolling-area)
  - [Basic Image](#basic-image)
  - [Basic Transform](#basic-transform)
  - [Basic Draw Text](#basic-draw-text)
  - [Basic Code Area](#basic-code-area)

## Basic Window

[examples/basic_window.rb](/examples/basic_window.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_window.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_window'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-window.png](/images/glimmer-dsl-libui-mac-basic-window.png) | ![glimmer-dsl-libui-windows-basic-window.png](/images/glimmer-dsl-libui-windows-basic-window.png) | ![glimmer-dsl-libui-linux-basic-window.png](/images/glimmer-dsl-libui-linux-basic-window.png)

[LibUI](https://github.com/kojix2/LibUI) Original Version:

```ruby
require 'libui'

UI = LibUI

UI.init

main_window = UI.new_window('hello world', 300, 200, 1)

UI.control_show(main_window)

UI.window_on_closing(main_window) do
  puts 'Bye Bye'
  UI.control_destroy(main_window)
  UI.quit
  0
end

UI.main
UI.quit
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('hello world', 300, 200, true) {
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (setting `window` properties instead of arguments):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window { # first 3 args can be set via properties with 4th arg has_menubar=true by default
  title 'hello world'
  content_size 300, 200
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

## Basic Child Window

[examples/basic_child_window.rb](/examples/basic_child_window.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_child_window.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_child_window.rb'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-child-window.png](/images/glimmer-dsl-libui-mac-basic-child-window.png) ![glimmer-dsl-libui-mac-basic-child-window-open.png](/images/glimmer-dsl-libui-mac-basic-child-window-open.png) | ![glimmer-dsl-libui-windows-basic-child-window.png](/images/glimmer-dsl-libui-windows-basic-child-window.png) ![glimmer-dsl-libui-windows-basic-child-window-open.png](/images/glimmer-dsl-libui-windows-basic-child-window-open.png) | ![glimmer-dsl-libui-linux-basic-child-window.png](/images/glimmer-dsl-libui-linux-basic-child-window.png) ![glimmer-dsl-libui-linux-basic-child-window-open.png](/images/glimmer-dsl-libui-linux-basic-child-window-open.png)

## Basic Button

[examples/basic_button.rb](/examples/basic_button.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_button.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_button'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-button.png](/images/glimmer-dsl-libui-mac-basic-button.png) ![glimmer-dsl-libui-mac-basic-button-msg-box.png](/images/glimmer-dsl-libui-mac-basic-button-msg-box.png) | ![glimmer-dsl-libui-windows-basic-button.png](/images/glimmer-dsl-libui-windows-basic-button.png) ![glimmer-dsl-libui-windows-basic-button-msg-box.png](/images/glimmer-dsl-libui-windows-basic-button-msg-box.png) | ![glimmer-dsl-libui-linux-basic-button.png](/images/glimmer-dsl-libui-linux-basic-button.png) ![glimmer-dsl-libui-linux-basic-button-msg-box.png](/images/glimmer-dsl-libui-linux-basic-button-msg-box.png)

[LibUI](https://github.com/kojix2/LibUI) Original Version:

```ruby
require 'libui'

UI = LibUI

UI.init

main_window = UI.new_window('hello world', 300, 200, 1)

button = UI.new_button('Button')

UI.button_on_clicked(button) do
  UI.msg_box(main_window, 'Information', 'You clicked the button')
end

UI.window_on_closing(main_window) do
  puts 'Bye Bye'
  UI.control_destroy(main_window)
  UI.quit
  0
end

UI.window_set_child(main_window, button)
UI.control_show(main_window)

UI.main
UI.quit
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('hello world', 300, 200) {
  button('Button') {
    on_clicked do
      msg_box('Information', 'You clicked the button')
    end
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

## Basic Entry

[examples/basic_entry.rb](/examples/basic_entry.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_entry.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_entry'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-entry.png](/images/glimmer-dsl-libui-mac-basic-entry.png) ![glimmer-dsl-libui-mac-basic-entry-msg-box.png](/images/glimmer-dsl-libui-mac-basic-entry-msg-box.png) | ![glimmer-dsl-libui-windows-basic-entry.png](/images/glimmer-dsl-libui-windows-basic-entry.png) ![glimmer-dsl-libui-windows-basic-entry-msg-box.png](/images/glimmer-dsl-libui-windows-basic-entry-msg-box.png) | ![glimmer-dsl-libui-linux-basic-entry.png](/images/glimmer-dsl-libui-linux-basic-entry.png) ![glimmer-dsl-libui-linux-basic-entry-msg-box.png](/images/glimmer-dsl-libui-linux-basic-entry-msg-box.png)

[LibUI](https://github.com/kojix2/LibUI) Original Version:

```ruby
require 'libui'

UI = LibUI

UI.init

main_window = UI.new_window('Basic Entry', 300, 50, 1)
UI.window_on_closing(main_window) do
  puts 'Bye Bye'
  UI.control_destroy(main_window)
  UI.quit
  0
end

hbox = UI.new_horizontal_box
UI.window_set_child(main_window, hbox)

entry = UI.new_entry
UI.entry_on_changed(entry) do
  puts UI.entry_text(entry).to_s
  $stdout.flush # For Windows
end
UI.box_append(hbox, entry, 1)

button = UI.new_button('Button')
UI.button_on_clicked(button) do
  text = UI.entry_text(entry).to_s
  UI.msg_box(main_window, 'You entered', text)
  0
end

UI.box_append(hbox, button, 0)

UI.control_show(main_window)
UI.main
UI.quit
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class BasicEntry
  include Glimmer
  
  attr_accessor :entry_text
  
  def launch
    window('Basic Entry', 300, 50) {
      horizontal_box {
        entry {
          # stretchy true # Smart default option for appending to horizontal_box
          text <=> [self, :entry_text, after_write: ->(text) {puts text; $stdout.flush}] # bidirectional data-binding between text property and entry_text attribute, printing after write to model.
        }
        
        button('Button') {
          stretchy false # stretchy property is available when control is nested under horizontal_box
          
          on_clicked do
            msg_box('You entered', entry_text)
          end
        }
      }
      
      on_closing do
        puts 'Bye Bye'
      end
    }.show
  end
end

BasicEntry.new.launch
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Basic Entry', 300, 50) {
  horizontal_box {
    e = entry {
      # stretchy true # Smart default option for appending to horizontal_box
    
      on_changed do
        puts e.text
        $stdout.flush # For Windows
      end
    }
    
    button('Button') {
      stretchy false # stretchy property is available when control is nested under horizontal_box
      
      on_clicked do
        text = e.text
        msg_box('You entered', text)
      end
    }
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

## Simple Notepad

[examples/simple_notepad.rb](/examples/simple_notepad.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/simple_notepad.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/simple_notepad'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-simple-notepad.png](/images/glimmer-dsl-libui-mac-simple-notepad.png) | ![glimmer-dsl-libui-windows-simple-notepad.png](/images/glimmer-dsl-libui-windows-simple-notepad.png) | ![glimmer-dsl-libui-linux-simple-notepad.png](/images/glimmer-dsl-libui-linux-simple-notepad.png)

[LibUI](https://github.com/kojix2/LibUI) Original Version:

```ruby
require 'libui'

UI = LibUI

UI.init

main_window = UI.new_window('Notepad', 500, 300, 1)
UI.window_on_closing(main_window) do
  puts 'Bye Bye'
  UI.control_destroy(main_window)
  UI.quit
  0
end

vbox = UI.new_vertical_box
UI.window_set_child(main_window, vbox)

entry = UI.new_non_wrapping_multiline_entry
UI.box_append(vbox, entry, 1)

UI.control_show(main_window)
UI.main
UI.quit
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Notepad', 500, 300) {
  on_closing do
    puts 'Bye Bye'
  end
  
  vertical_box {
    non_wrapping_multiline_entry
  }
}.show
```

## Font Button

[examples/font_button.rb](/examples/font_button.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/font_button.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/font_button'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-font-button.png](/images/glimmer-dsl-libui-mac-font-button.png) ![glimmer-dsl-libui-mac-font-button-selection.png](/images/glimmer-dsl-libui-mac-font-button-selection.png) | ![glimmer-dsl-libui-windows-font-button.png](/images/glimmer-dsl-libui-windows-font-button.png) ![glimmer-dsl-libui-windows-font-button-selection.png](/images/glimmer-dsl-libui-windows-font-button-selection.png) | ![glimmer-dsl-libui-linux-font-button.png](/images/glimmer-dsl-libui-linux-font-button.png) ![glimmer-dsl-libui-linux-font-button-selection.png](/images/glimmer-dsl-libui-linux-font-button-selection.png)

[LibUI](https://github.com/kojix2/LibUI) Original Version:

```ruby
require 'libui'

UI = LibUI

UI.init

main_window = UI.new_window('hello world', 300, 200, 1)

font_button = UI.new_font_button
font_descriptor = UI::FFI::FontDescriptor.malloc
font_descriptor.to_ptr.free = Fiddle::RUBY_FREE
UI.font_button_on_changed(font_button) do
  UI.font_button_font(font_button, font_descriptor)
  p family: font_descriptor.Family.to_s,
    size: font_descriptor.Size,
    weight: font_descriptor.Weight,
    italic: font_descriptor.Italic,
    stretch: font_descriptor.Stretch
end

UI.window_on_closing(main_window) do
  puts 'Bye Bye'
  UI.control_destroy(main_window)
  UI.quit
  0
end

UI.window_set_child(main_window, font_button)
UI.control_show(main_window)

UI.main
UI.quit

```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class FontButton
  include Glimmer
  
  attr_accessor :font_descriptor
  
  def launch
    window('hello world', 300, 200) {
      font_button {
        font <=> [self, :font_descriptor, after_write: -> { p font_descriptor }]
      }
      
      on_closing do
        puts 'Bye Bye'
      end
    }.show
  end
end

FontButton.new.launch
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('hello world', 300, 200) {
  font_button { |fb|
    on_changed do
      font_descriptor = fb.font
      p font_descriptor
    end
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

## Color Button

[examples/color_button.rb](/examples/color_button.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/color_button.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/color_button'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-color-button.png](/images/glimmer-dsl-libui-mac-color-button.png) ![glimmer-dsl-libui-mac-color-button-selection.png](/images/glimmer-dsl-libui-mac-color-button-selection.png) | ![glimmer-dsl-libui-windows-color-button.png](/images/glimmer-dsl-libui-windows-color-button.png) ![glimmer-dsl-libui-windows-color-button-selection.png](/images/glimmer-dsl-libui-windows-color-button-selection.png) | ![glimmer-dsl-libui-linux-color-button.png](/images/glimmer-dsl-libui-linux-color-button.png) ![glimmer-dsl-libui-linux-color-button-selection.png](/images/glimmer-dsl-libui-linux-color-button-selection.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class ColorButton
  include Glimmer
  
  attr_accessor :selected_color
  
  def initialize
    @selected_color = :blue
  end
  
  def launch
    window('color button', 240) {
      color_button {
        color <=> [self, :selected_color, after_write: ->(color) {p color}]
      }
    }.show
  end
end

ColorButton.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('color button', 240) {
  color_button { |cb|
    color :blue
    
    on_changed do
      rgba = cb.color
      p rgba
    end
  }
}.show
```

## Date Time Picker

[examples/date_time_picker.rb](/examples/date_time_picker.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/date_time_picker.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/date_time_picker'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-date-time-picker.png](/images/glimmer-dsl-libui-mac-date-time-picker.png) | ![glimmer-dsl-libui-windows-date-time-picker.png](/images/glimmer-dsl-libui-windows-date-time-picker.png) | ![glimmer-dsl-libui-linux-date-time-picker.png](/images/glimmer-dsl-libui-linux-date-time-picker.png)

[LibUI](https://github.com/kojix2/LibUI) Original Version:

```ruby
require 'libui'

UI = LibUI

UI.init

vbox = UI.new_vertical_box

date_time_picker = UI.new_date_time_picker

time = UI::FFI::TM.malloc

UI.date_time_picker_on_changed(date_time_picker) do
  UI.date_time_picker_time(date_time_picker, time)
  p sec: time.tm_sec,
    min: time.tm_min,
    hour: time.tm_hour,
    mday: time.tm_mday,
    mon: time.tm_mon,
    year: time.tm_year,
    wday: time.tm_wday,
    yday: time.tm_yday,
    isdst: time.tm_isdst
end
UI.box_append(vbox, date_time_picker, 1)

main_window = UI.new_window('Date Time Pickers', 300, 200, 1)
UI.window_on_closing(main_window) do
  puts 'Bye Bye'
  UI.control_destroy(main_window)
  UI.quit
  0
end
UI.window_set_child(main_window, vbox)
UI.control_show(main_window)

UI.main
UI.quit
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class DateTimePicker
  include Glimmer
  
  attr_accessor :picked_time
  
  def launch
    window('Date Time Pickers', 300, 200) {
      vertical_box {
        date_time_picker {
          time <=> [self, :picked_time, after_write: ->(time) { p time }]
        }
      }
      
      on_closing do
        puts 'Bye Bye'
      end
    }.show
  end
end

DateTimePicker.new.launch
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Date Time Pickers', 300, 200) {
  vertical_box {
    date_time_picker { |dtp|
      on_changed do
        time = dtp.time
        p time
      end
    }
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

## Form

[examples/form.rb](/examples/form.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/form.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/form'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-form.png](/images/glimmer-dsl-libui-mac-form.png) ![glimmer-dsl-libui-mac-form-msg-box.png](/images/glimmer-dsl-libui-mac-form-msg-box.png) | ![glimmer-dsl-libui-windows-form.png](/images/glimmer-dsl-libui-windows-form.png) ![glimmer-dsl-libui-windows-form-msg-box.png](/images/glimmer-dsl-libui-windows-form-msg-box.png) | ![glimmer-dsl-libui-linux-form.png](/images/glimmer-dsl-libui-linux-form.png) ![glimmer-dsl-libui-linux-form-msg-box.png](/images/glimmer-dsl-libui-linux-form-msg-box.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class Form
  include Glimmer
  
  attr_accessor :first_name, :last_name, :phone, :email
  
  def launch
    window('Form') {
      margined true
      
      vertical_box {
        form {
          entry {
            label 'First Name' # label property is available when control is nested under form
            text <=> [self, :first_name] # bidirectional data-binding of entry text property to self first_name attribute
          }
          
          entry {
            label 'Last Name' # label property is available when control is nested under form
            text <=> [self, :last_name]
          }
          
          entry {
            label 'Phone' # label property is available when control is nested under form
            text <=> [self, :phone]
          }
          
          entry {
            label 'Email' # label property is available when control is nested under form
            text <=> [self, :email]
          }
        }
        
        button('Display Info') {
          stretchy false
          
          on_clicked do
            msg_box('Info', "#{first_name} #{last_name} has phone #{phone} and email #{email}")
          end
        }
      }
    }.show
  end
end

Form.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (without [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Form') {
  margined true
  
  vertical_box {
    form {
      @first_name_entry = entry {
        label 'First Name' # label property is available when control is nested under form
      }
      
      @last_name_entry = entry {
        label 'Last Name' # label property is available when control is nested under form
      }
      
      @phone_entry = entry {
        label 'Phone' # label property is available when control is nested under form
      }
      
      @email_entry = entry {
        label 'Email' # label property is available when control is nested under form
      }
    }
    
    button('Display Info') {
      stretchy false
      
      on_clicked do
        msg_box('Info', "#{@first_name_entry.text} #{@last_name_entry.text} has phone #{@phone_entry.text} and email #{@email_entry.text}")
      end
    }
  }
}.show
```

## Basic Table

[examples/basic_table.rb](/examples/basic_table.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_table.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_table'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-table.png](/images/glimmer-dsl-libui-mac-basic-table.png) | ![glimmer-dsl-libui-windows-basic-table.png](/images/glimmer-dsl-libui-windows-basic-table.png) | ![glimmer-dsl-libui-linux-basic-table.png](/images/glimmer-dsl-libui-linux-basic-table.png)

[LibUI](https://github.com/kojix2/LibUI) Original Version:

```ruby
require 'libui'

UI = LibUI

UI.init

main_window = UI.new_window('Animal sounds', 300, 200, 1)

hbox = UI.new_horizontal_box
UI.window_set_child(main_window, hbox)

data = [
  %w[cat meow],
  %w[dog woof],
  %w[checken cock-a-doodle-doo],
  %w[horse neigh],
  %w[cow moo]
]

# Protects BlockCaller objects from garbage collection.
@blockcaller = []
def rbcallback(*args, &block)
  args << [0] if args.size == 1 # Argument types are ommited
  blockcaller = Fiddle::Closure::BlockCaller.new(*args, &block)
  @blockcaller << blockcaller
  blockcaller
end

model_handler = UI::FFI::TableModelHandler.malloc
model_handler.NumColumns   = rbcallback(4) { 2 }
model_handler.ColumnType   = rbcallback(4) { 0 }
model_handler.NumRows      = rbcallback(4) { 5 }
model_handler.CellValue    = rbcallback(1, [1, 1, 4, 4]) do |_, _, row, column|
  UI.new_table_value_string(data[row][column])
end
model_handler.SetCellValue = rbcallback(0, [0]) {}

model = UI.new_table_model(model_handler)

table_params = UI::FFI::TableParams.malloc
table_params.Model = model
table_params.RowBackgroundColorModelColumn = -1

table = UI.new_table(table_params)
UI.table_append_text_column(table, 'Animal', 0, -1)
UI.table_append_text_column(table, 'Description', 1, -1)

UI.box_append(hbox, table, 1)
UI.control_show(main_window)

UI.window_on_closing(main_window) do
  puts 'Bye Bye'
  UI.control_destroy(main_window)
  UI.free_table_model(model)
  UI.quit
  0
end

UI.main
UI.quit
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

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

window('Animal sounds', 300, 200) {
  horizontal_box {
    table {
      text_column('Animal')
      text_column('Description')

      cell_rows data
    }
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

## Basic Table Image

Note that behavior varies per platform (i.e. how `table` chooses to size images by default).

[examples/basic_table_image.rb](/examples/basic_table_image.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_table_image.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_table_image'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-table-image.png](/images/glimmer-dsl-libui-mac-basic-table-image.png) | ![glimmer-dsl-libui-windows-basic-table-image.png](/images/glimmer-dsl-libui-windows-basic-table-image.png) | ![glimmer-dsl-libui-linux-basic-table-image.png](/images/glimmer-dsl-libui-linux-basic-table-image.png)

[LibUI](https://github.com/kojix2/LibUI) Original Version:

```ruby
# NOTE:
# This example displays images that can be freely downloaded from the Studio Ghibli website.

require 'libui'
require 'chunky_png'
require 'open-uri'

UI = LibUI

UI.init

main_window = UI.new_window('The Red Turtle', 310, 350, 0)

hbox = UI.new_horizontal_box
UI.window_set_child(main_window, hbox)

IMAGES = []

50.times do |i|
  url = format('https://www.ghibli.jp/gallery/thumb-redturtle%03d.png', (i + 1))
  puts "Processing Image: #{url}"
  f = URI.open(url)
  canvas = ChunkyPNG::Canvas.from_io(f)
  f.close
  data = canvas.to_rgba_stream
  width = canvas.width
  height = canvas.height
  image = UI.new_image(width, height)
  UI.image_append(image, data, width, height, width * 4)
  IMAGES << image
rescue StandardError => e
  warn url, e.message
end

# Protects BlockCaller objects from garbage collection.
@blockcaller = []
def rbcallback(*args, &block)
  args << [0] if args.size == 1 # Argument types are ommited
  blockcaller = Fiddle::Closure::BlockCaller.new(*args, &block)
  @blockcaller << blockcaller
  blockcaller
end

model_handler = UI::FFI::TableModelHandler.malloc
model_handler.NumColumns   = rbcallback(4) { 1 }
model_handler.ColumnType   = rbcallback(4) { 1 } # Image
model_handler.NumRows      = rbcallback(4) { IMAGES.size }
model_handler.CellValue    = rbcallback(1, [1, 1, 4, 4]) do |_, _, row, _column|
  UI.new_table_value_image(/images[row])
end
model_handler.SetCellValue = rbcallback(0, [0]) {}

model = UI.new_table_model(model_handler)

table_params = UI::FFI::TableParams.malloc
table_params.Model = model
table_params.RowBackgroundColorModelColumn = -1

table = UI.new_table(table_params)
UI.table_append_image_column(table, 'www.ghibli.jp/works/red-turtle', 0)

UI.box_append(hbox, table, 1)
UI.control_show(main_window)

UI.window_on_closing(main_window) do
  puts 'Bye Bye'
  UI.control_destroy(main_window)
  UI.free_table_model(model)
  IMAGES.each { |i| UI.free_image(i) }
  UI.quit
  0
end

UI.main
UI.quit
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (passing file url as image):

```ruby
# frozen_string_literal: true

# NOTE:
# This example displays images that can be freely downloaded from the Studio Ghibli website.

require 'glimmer-dsl-libui'

include Glimmer

IMAGE_ROWS = []

50.times do |i|
  url = format('https://www.ghibli.jp/gallery/thumb-redturtle%03d.png', (i + 1))
  puts "Processing Image: #{url}"; $stdout.flush # for Windows
  IMAGE_ROWS << [url] # array of one column cell
rescue StandardError => e
  warn url, e.message
end

window('The Red Turtle', 310, 350, false) {
  horizontal_box {
    table {
      image_column('www.ghibli.jp/works/red-turtle')
      
      cell_rows IMAGE_ROWS
    }
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (automatic construction of `image`):

```ruby
# NOTE:
# This example displays images that can be freely downloaded from the Studio Ghibli website.

require 'glimmer-dsl-libui'

include Glimmer

IMAGE_ROWS = []

50.times do |i|
  url = format('https://www.ghibli.jp/gallery/thumb-redturtle%03d.png', (i + 1))
  puts "Processing Image: #{url}"; $stdout.flush # for Windows
  IMAGE_ROWS << [image(url)] # array of one column cell
rescue StandardError => e
  warn url, e.message
end

window('The Red Turtle', 310, 350, false) {
  horizontal_box {
    table {
      image_column('www.ghibli.jp/works/red-turtle')
      
      cell_rows IMAGE_ROWS
    }
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 3 (manual construction of `image` from `image_part`):

```ruby
# NOTE:
# This example displays images that can be freely downloaded from the Studio Ghibli website.

require 'glimmer-dsl-libui'
require 'chunky_png'
require 'open-uri'

include Glimmer

IMAGE_ROWS = []

50.times do |i|
  url = format('https://www.ghibli.jp/gallery/thumb-redturtle%03d.png', (i + 1))
  puts "Processing Image: #{url}"
  f = URI.open(url)
  canvas = ChunkyPNG::Canvas.from_io(f)
  f.close
  data = canvas.to_rgba_stream
  width = canvas.width
  height = canvas.height
  img = image {
    image_part(data, width, height, width * 4)
  }
  IMAGE_ROWS << [img] # array of one column cell
rescue StandardError => e
  warn url, e.message
end

window('The Red Turtle', 310, 350, false) {
  horizontal_box {
    table {
      image_column('www.ghibli.jp/works/red-turtle', 0)
      
      cell_rows IMAGE_ROWS
    }
  }
    
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

## Basic Table Image Text

Note that behavior varies per platform (i.e. how `table` chooses to size images by default).

[examples/basic_table_image_text.rb](/examples/basic_table_image_text.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_table_image_text.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_table_image_text'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-table-image-text.png](/images/glimmer-dsl-libui-mac-basic-table-image-text.png) | ![glimmer-dsl-libui-windows-basic-table-image-text.png](/images/glimmer-dsl-libui-windows-basic-table-image-text.png) | ![glimmer-dsl-libui-linux-basic-table-image-text.png](/images/glimmer-dsl-libui-linux-basic-table-image-text.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (passing file url as image):

```ruby
# frozen_string_literal: true

# NOTE:
# This example displays images that can be freely downloaded from the Studio Ghibli website.

require 'glimmer-dsl-libui'

include Glimmer

IMAGE_ROWS = []

5.times do |i|
  url = format('https://www.ghibli.jp/gallery/thumb-redturtle%03d.png', (i + 1))
  puts "Processing Image: #{url}"; $stdout.flush # for Windows
  text = url.sub('https://www.ghibli.jp/gallery/thumb-redturtle', '').sub('.png', '')
  IMAGE_ROWS << [[url, text], [url, text]] # cell values are dual-element arrays
rescue StandardError => e
  warn url, e.message
end

window('The Red Turtle', 670, 350) {
  horizontal_box {
    table {
      image_text_column('image/number')
      image_text_column('image/number (editable)') {
        editable true
      }
      
      cell_rows IMAGE_ROWS
    }
  }
}.show
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (automatic construction of `image`):

```ruby
# NOTE:
# This example displays images that can be freely downloaded from the Studio Ghibli website.

require 'glimmer-dsl-libui'

include Glimmer

IMAGE_ROWS = []

5.times do |i|
  url = format('https://www.ghibli.jp/gallery/thumb-redturtle%03d.png', (i + 1))
  puts "Processing Image: #{url}"; $stdout.flush # for Windows
  text = url.sub('https://www.ghibli.jp/gallery/thumb-redturtle', '').sub('.png', '')
  img = image(url)
  IMAGE_ROWS << [[img, text], [img, text]] # cell values are dual-element arrays
rescue StandardError => e
  warn url, e.message
end

window('The Red Turtle', 670, 350) {
  horizontal_box {
    table {
      image_text_column('image/number')
      image_text_column('image/number (editable)') {
        editable true
      }
      
      cell_rows IMAGE_ROWS
    }
  }
}.show
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (manual construction of `image` from `image_part`):

```ruby
# NOTE:
# This example displays images that can be freely downloaded from the Studio Ghibli website.

require 'glimmer-dsl-libui'
require 'chunky_png'
require 'open-uri'

include Glimmer

IMAGE_ROWS = []

5.times do |i|
  url = format('https://www.ghibli.jp/gallery/thumb-redturtle%03d.png', (i + 1))
  puts "Processing Image: #{url}"
  f = URI.open(url)
  canvas = ChunkyPNG::Canvas.from_io(f)
  f.close
  data = canvas.to_rgba_stream
  width = canvas.width
  height = canvas.height
  img = image {
    image_part(data, width, height, width * 4)
  }
  text = url.sub('https://www.ghibli.jp/gallery/thumb-redturtle', '').sub('.png', '')
  IMAGE_ROWS << [[img, text], [img, text]] # cell values are dual-element arrays
rescue StandardError => e
  warn url, e.message
end

window('The Red Turtle', 670, 350) {
  horizontal_box {
    table {
      image_text_column('image/number')
      image_text_column('image/number (editable)') {
        editable true
      }
      
      cell_rows IMAGE_ROWS
    }
  }
}.show
```

## Basic Table Button

[examples/basic_table_button.rb](/examples/basic_table_button.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_table_button.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_table_button'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-table-button.png](/images/glimmer-dsl-libui-mac-basic-table-button.png) ![glimmer-dsl-libui-mac-basic-table-button-deleted.png](/images/glimmer-dsl-libui-mac-basic-table-button-deleted.png) | ![glimmer-dsl-libui-windows-basic-table-button.png](/images/glimmer-dsl-libui-windows-basic-table-button.png) ![glimmer-dsl-libui-windows-basic-table-button-deleted.png](/images/glimmer-dsl-libui-windows-basic-table-button-deleted.png) | ![glimmer-dsl-libui-linux-basic-table-button.png](/images/glimmer-dsl-libui-linux-basic-table-button.png) ![glimmer-dsl-libui-linux-basic-table-button-deleted.png](/images/glimmer-dsl-libui-linux-basic-table-button-deleted.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with explicit [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

class BasicTableButton
  BasicAnimal = Struct.new(:name, :sound)
  
  class Animal < BasicAnimal
    def action
      'delete'
    end
  end
  
  include Glimmer
  
  attr_accessor :animals
  
  def initialize
    @animals = [
      Animal.new('cat', 'meow'),
      Animal.new('dog', 'woof'),
      Animal.new('chicken', 'cock-a-doodle-doo'),
      Animal.new('horse', 'neigh'),
      Animal.new('cow', 'moo'),
    ]
  end
  
  def launch
    window('Animal sounds', 400, 200) {
      horizontal_box {
        table {
          text_column('Animal')
          text_column('Description')
          button_column('Action') {
            on_clicked do |row|
              # Option 1: direct data deletion is the simpler solution
#               @animals.delete_at(row) # automatically deletes actual table row due to explicit data-binding
              
              # Option 2: cloning only to demonstrate table row deletion upon explicit setting of animals attribute (cloning is not recommended beyond demonstrating this point)
              new_animals = @animals.clone
              new_animals.delete_at(row)
              self.animals = new_animals # automatically loses deleted table row due to explicit data-binding
            end
          }
    
          cell_rows <= [self, :animals, column_attributes: {'Animal' => :name, 'Description' => :sound}]
          
          # explicit unidirectional data-binding of table cell_rows to self.animals
          on_changed do |row, type, row_data|
            puts "Row #{row} #{type}: #{row_data}"
            $stdout.flush
          end
        }
      }
    }.show
  end
end

BasicTableButton.new.launch
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (with implicit [data-binding](#data-binding)):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

data = [
  %w[cat meow delete],
  %w[dog woof delete],
  %w[chicken cock-a-doodle-doo delete],
  %w[horse neigh delete],
  %w[cow moo delete]
]

window('Animal sounds', 300, 200) {
  horizontal_box {
    table {
      text_column('Animal')
      text_column('Description')
      button_column('Action') {
        on_clicked do |row|
          data.delete_at(row) # automatically deletes actual table row due to implicit data-binding
        end
      }

      cell_rows data # implicit data-binding
      
      on_changed do |row, type, row_data|
        puts "Row #{row} #{type}: #{row_data}"
      end
    }
  }
}.show
```

## Basic Table Checkbox

[examples/basic_table_checkbox.rb](/examples/basic_table_checkbox.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_table_checkbox.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_table_checkbox'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-table-checkbox.png](/images/glimmer-dsl-libui-mac-basic-table-checkbox.png) | ![glimmer-dsl-libui-windows-basic-table-checkbox.png](/images/glimmer-dsl-libui-windows-basic-table-checkbox.png) | ![glimmer-dsl-libui-linux-basic-table-checkbox.png](/images/glimmer-dsl-libui-linux-basic-table-checkbox.png)

## Basic Table Checkbox Text

[examples/basic_table_checkbox_text.rb](/examples/basic_table_checkbox_text.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_table_checkbox_text.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_table_checkbox_text'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-table-checkbox-text.png](/images/glimmer-dsl-libui-mac-basic-table-checkbox-text.png) | ![glimmer-dsl-libui-windows-basic-table-checkbox-text.png](/images/glimmer-dsl-libui-windows-basic-table-checkbox-text.png) | ![glimmer-dsl-libui-linux-basic-table-checkbox-text.png](/images/glimmer-dsl-libui-linux-basic-table-checkbox-text.png)

## Basic Table Progress Bar

[examples/basic_table_progress_bar.rb](/examples/basic_table_progress_bar.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_table_progress_bar.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_table_progress_bar'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-table-progress-bar.png](/images/glimmer-dsl-libui-mac-basic-table-progress-bar.png) | ![glimmer-dsl-libui-windows-basic-table-progress-bar.png](/images/glimmer-dsl-libui-windows-basic-table-progress-bar.png) | ![glimmer-dsl-libui-linux-basic-table-progress-bar.png](/images/glimmer-dsl-libui-linux-basic-table-progress-bar.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

data = [
  ['task 1', 0],
  ['task 2', 15],
  ['task 3', 100],
  ['task 4', 75],
  ['task 5', -1],
]

window('Task Progress', 300, 200) {
  vertical_box {
    table {
      text_column('Task')
      progress_bar_column('Progress')

      cell_rows data # implicit data-binding
    }
    
    button('Mark All As Done') {
      stretchy false
      
      on_clicked do
        data.each_with_index do |row_data, row|
          data[row][1] = 100 # automatically updates table due to implicit data-binding
        end
      end
    }
  }
}.show
```

## Basic Table Color

[examples/basic_table_color.rb](/examples/basic_table_color.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_table_color.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_table_color'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-table-color.png](/images/glimmer-dsl-libui-mac-basic-table-color.png) | ![glimmer-dsl-libui-windows-basic-table-color.png](/images/glimmer-dsl-libui-windows-basic-table-color.png) | ![glimmer-dsl-libui-linux-basic-table-color.png](/images/glimmer-dsl-libui-linux-basic-table-color.png)

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version (with explicit [data-binding](#data-binding) to model rows using a presenter)

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (with implicit [data-binding](#data-binding) to raw data rows)

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 3 (with implicit [data-binding](#data-binding) to raw data rows and manual construction of [libui](https://github.com/andlabs/libui) `image` from `image_part`)

## Basic Table Selection

[examples/basic_table_selection.rb](/examples/basic_table_selection.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_table_selection.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_table_selection'"
```

![glimmer-dsl-libui-mac-basic-table-selection-one.png](/images/glimmer-dsl-libui-mac-basic-table-selection-one.png)
![glimmer-dsl-libui-mac-basic-table-selection-zero-or-one.png](/images/glimmer-dsl-libui-mac-basic-table-selection-zero-or-one.png)
![glimmer-dsl-libui-mac-basic-table-selection-zero-or-many.png](/images/glimmer-dsl-libui-mac-basic-table-selection-zero-or-many.png)
![glimmer-dsl-libui-mac-basic-table-selection-none.png](/images/glimmer-dsl-libui-mac-basic-table-selection-none.png)
![glimmer-dsl-libui-mac-basic-table-selection-header-not-visible.png](/images/glimmer-dsl-libui-mac-basic-table-selection-header-not-visible.png)

Version 1 (automatic sorting and data-binding):

[examples/basic_table_selection.rb](/examples/basic_table_selection.rb)

Version 2 (custom sorting and data-binding):

[examples/basic_table_selection2.rb](/examples/basic_table_selection2.rb)

Version 3 (custom sorting without data-binding):

[examples/basic_table_selection3.rb](/examples/basic_table_selection3.rb)

## Basic Area

[examples/basic_area.rb](/examples/basic_area.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_area.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_area'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-area.png](/images/glimmer-dsl-libui-mac-basic-area.png) | ![glimmer-dsl-libui-windows-basic-area.png](/images/glimmer-dsl-libui-windows-basic-area.png) | ![glimmer-dsl-libui-linux-basic-area.png](/images/glimmer-dsl-libui-linux-basic-area.png)

[LibUI](https://github.com/kojix2/LibUI) Original Version:

```ruby
require 'libui'

UI = LibUI

UI.init

handler = UI::FFI::AreaHandler.malloc
area    = UI.new_area(handler)
brush   = UI::FFI::DrawBrush.malloc

handler_draw_event = Fiddle::Closure::BlockCaller.new(0, [1, 1, 1]) do |_, _, area_draw_params|
  path = UI.draw_new_path(0)
  UI.draw_path_add_rectangle(path, 0, 0, 400, 400)
  UI.draw_path_end(path)
  brush.Type = 0
  brush.R = 0.4
  brush.G = 0.4
  brush.B = 0.8
  brush.A = 1.0
  area_draw_params = UI::FFI::AreaDrawParams.new(area_draw_params)
  UI.draw_fill(area_draw_params.Context, path, brush.to_ptr)
  UI.draw_free_path(path)
end

handler.Draw         = handler_draw_event
handler.MouseEvent   = Fiddle::Closure::BlockCaller.new(0, [0]) {}
handler.MouseCrossed = Fiddle::Closure::BlockCaller.new(0, [0]) {}
handler.DragBroken   = Fiddle::Closure::BlockCaller.new(0, [0]) {}
handler.KeyEvent     = Fiddle::Closure::BlockCaller.new(0, [0]) {}

box = UI.new_vertical_box
UI.box_set_padded(box, 1)
UI.box_append(box, area, 1)

main_window = UI.new_window('Basic Area', 400, 400, 1)
UI.window_set_margined(main_window, 1)
UI.window_set_child(main_window, box)

UI.window_on_closing(main_window) do
  UI.control_destroy(main_window)
  UI.quit
  0
end
UI.control_show(main_window)

UI.main
UI.quit
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Basic Area', 400, 400) {
  margined true
  
  vertical_box {
    area {
      path { # a stable path is added declaratively
        rectangle(0, 0, 400, 400)
        
        fill r: 102, g: 102, b: 204, a: 1.0
      }
    }
  }
}.show
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (semi-declarative `on_draw` dynamic `path` approach):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Basic Area', 400, 400) {
  margined true
  
  vertical_box {
    area {
      on_draw do |area_draw_params|
        path { # a dynamic path is added semi-declaratively inside on_draw block
          rectangle(0, 0, 400, 400)
          
          fill r: 102, g: 102, b: 204, a: 1.0
        }
      end
    }
  }
}.show
```

## Basic Scrolling Area

[examples/basic_scrolling_area.rb](/examples/basic_scrolling_area.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_scrolling_area.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_scrolling_area'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-dynamic-area.png](/images/glimmer-dsl-libui-mac-basic-scrolling-area.png) ![glimmer-dsl-libui-mac-dynamic-area-updated.png](/images/glimmer-dsl-libui-mac-basic-scrolling-area-scrolled.png) | ![glimmer-dsl-libui-windows-dynamic-area.png](/images/glimmer-dsl-libui-windows-basic-scrolling-area.png) ![glimmer-dsl-libui-windows-dynamic-area-updated.png](/images/glimmer-dsl-libui-windows-basic-scrolling-area-scrolled.png) | ![glimmer-dsl-libui-linux-dynamic-area.png](/images/glimmer-dsl-libui-linux-basic-scrolling-area.png) ![glimmer-dsl-libui-linux-dynamic-area-updated.png](/images/glimmer-dsl-libui-linux-basic-scrolling-area-scrolled.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

class BasicScrollingArea
  include Glimmer
  
  SCROLLING_AREA_WIDTH = 800
  SCROLLING_AREA_HEIGHT = 400
  SCROLLING_AREA_PADDING_X = 20
  SCROLLING_AREA_PADDING_Y = 20
  
  def initialize
    @x = SCROLLING_AREA_PADDING_X
    @y = SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y
    create_gui
    Glimmer::LibUI.timer(0.01) do
      @x += SCROLLING_AREA_PADDING_X
      @y = [[@y + rand(SCROLLING_AREA_PADDING_Y*4)*(rand(2) == 0 ? -1 : 1), SCROLLING_AREA_PADDING_Y].max, SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y].min
      @graph.content { # re-open @graph's content and add a line
        line(@x, @y)
      }
      # if there is a need to enlarge scrolling area, call `@scrolling_area.set_size(new_width, new_height)`
      @scrolling_area.scroll_to(@x - (SCROLLING_AREA_WIDTH/2), @y) # 3rd and 4th arguments for width and height are assumed as those of main window by default if not supplied
      # return false to stop timer once @x exceeds scrolling area width - padding
      false if @x >= (SCROLLING_AREA_WIDTH - SCROLLING_AREA_PADDING_X*2)
    end
  end
  
  def launch
    @main_window.show
  end
  
  def x_axis
    polyline(SCROLLING_AREA_PADDING_X, SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y, SCROLLING_AREA_WIDTH - SCROLLING_AREA_PADDING_X*2, SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y) {
      stroke :black, thickness: 3
    }
    
    ((SCROLLING_AREA_WIDTH - SCROLLING_AREA_PADDING_X*4) / SCROLLING_AREA_PADDING_X).times do |x_multiplier|
      x = x_multiplier*SCROLLING_AREA_PADDING_X + SCROLLING_AREA_PADDING_X*2
      y = SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y
      
      polyline(x, y, x, y + SCROLLING_AREA_PADDING_Y/2) {
        stroke :black, thickness: 2
      }
    end
  end
  
  def y_axis
    polyline(SCROLLING_AREA_PADDING_X, SCROLLING_AREA_PADDING_Y, SCROLLING_AREA_PADDING_X, SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y) {
      stroke :black, thickness: 3
    }
    
    ((SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y*3) / SCROLLING_AREA_PADDING_Y).times do |y_multiplier|
      x = SCROLLING_AREA_PADDING_X
      y = y_multiplier*SCROLLING_AREA_PADDING_Y + SCROLLING_AREA_PADDING_Y*2
      
      polyline(x, y, x - SCROLLING_AREA_PADDING_X/2, y) {
        stroke :black, thickness: 2
      }
    end
  end
  
  def create_gui
    @main_window = window('Basic Scrolling Area', SCROLLING_AREA_WIDTH / 2, SCROLLING_AREA_HEIGHT) {
      resizable false
      
      @scrolling_area = scrolling_area(SCROLLING_AREA_WIDTH, SCROLLING_AREA_HEIGHT) {
        x_axis
        y_axis
        
        @graph = figure(SCROLLING_AREA_PADDING_X, SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y) {
          stroke :blue, thickness: 2
        }
      }
    }
  end
end

BasicScrollingArea.new.launch
```

## Basic Image

Please note the caveats of [Area Image](#area-image) **(Alpha Feature)** with regards to this example.

[examples/basic_image.rb](/examples/basic_image.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_image.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_image'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-image.png](/images/glimmer-dsl-libui-mac-basic-image.png) | ![glimmer-dsl-libui-windows-basic-image.png](/images/glimmer-dsl-libui-windows-basic-image.png) | ![glimmer-dsl-libui-linux-basic-image.png](/images/glimmer-dsl-libui-linux-basic-image.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Basic Image', 96, 96) {
  area {
    # image is not a real LibUI control. It is built in Glimmer as a custom control that renders
    # tiny pixels/lines as rectangle paths. As such, it does not have good performance, but can
    # be used in exceptional circumstances where an image control is really needed.
    #
    # Furthermore, adding image directly under area is even slower due to taking up more memory for every
    # image pixel rendered. Check basic_image2.rb for a faster alternative using on_draw manually.
    #
    # It is recommended to pass width/height args to shrink image and achieve faster performance.
    image(File.expand_path('../icons/glimmer.png', __dir__), height: 96) # width is automatically calculated from height while preserving original aspect ratio
#     image(File.expand_path('../icons/glimmer.png', __dir__), width: 96, height: 96) # you can specify both width, height options as alternative
#     image(File.expand_path('../icons/glimmer.png', __dir__), 96, 96) # you can specify width, height args as alternative
#     image(File.expand_path('../icons/glimmer.png', __dir__), 0, 0, 96, 96) # you can specify x, y, width, height args as alternative
#     image(File.expand_path('../icons/glimmer.png', __dir__), x: 0, y: 0, width: 96, height: 96) # you can specify x, y, width, height options as alternative
  }
}.show
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2 (better performance via `on_draw`):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Basic Image', 96, 96) {
  area {
    on_draw do |area_draw_params|
      image(File.expand_path('../icons/glimmer.png', __dir__), height: 96)
    end
  }
}.show
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 3 (explicit properties):

```ruby
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
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 4 (better performance with `on_draw` when setting explicit properties):

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Basic Image', 96, 96) {
  area {
    on_draw do |area_draw_params|
      image {
        file File.expand_path('../icons/glimmer.png', __dir__)
        height 96
      }
    end
  }
}.show
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 5 (fully manual pixel-by-pixel rendering):

```ruby
# frozen_string_literal: true

# This is the manual way of rendering an image unto an area control.
# It could come in handy in special situations.
# Otherwise, it is recommended to simply utilize the `image` control that
# can be nested under area or area on_draw listener to automate all this work.

require 'glimmer-dsl-libui'
require 'chunky_png'

include Glimmer

puts 'Parsing image...'; $stdout.flush

f = File.open(File.expand_path('../icons/glimmer.png', __dir__))
canvas = ChunkyPNG::Canvas.from_io(f)
f.close
canvas.resample_nearest_neighbor!(96, 96)
data = canvas.to_rgba_stream
width = canvas.width
height = canvas.height
puts "Image width: #{width}"
puts "Image height: #{height}"

puts 'Parsing colors...'; $stdout.flush

color_maps = height.times.map do |y|
  width.times.map do |x|
    r = data[(y*width + x)*4].ord
    g = data[(y*width + x)*4 + 1].ord
    b = data[(y*width + x)*4 + 2].ord
    a = data[(y*width + x)*4 + 3].ord
    {x: x, y: y, color: {r: r, g: g, b: b, a: a}}
  end
end.flatten
puts "#{color_maps.size} pixels to render..."; $stdout.flush

puts 'Parsing shapes...'; $stdout.flush

shape_maps = []
original_color_maps = color_maps.dup
indexed_original_color_maps = Hash[original_color_maps.each_with_index.to_a]
color_maps.each do |color_map|
  index = indexed_original_color_maps[color_map]
  @rectangle_start_x ||= color_map[:x]
  @rectangle_width ||= 1
  if color_map[:x] < width - 1 && color_map[:color] == original_color_maps[index + 1][:color]
    @rectangle_width += 1
  else
    if color_map[:x] > 0 && color_map[:color] == original_color_maps[index - 1][:color]
      shape_maps << {x: @rectangle_start_x, y: color_map[:y], width: @rectangle_width, height: 1, color: color_map[:color]}
    else
      shape_maps << {x: color_map[:x], y: color_map[:y], width: 1, height: 1, color: color_map[:color]}
    end
    @rectangle_width = 1
    @rectangle_start_x = color_map[:x] == width - 1 ? 0 : color_map[:x] + 1
  end
end
puts "#{shape_maps.size} shapes to render..."; $stdout.flush

puts 'Rendering image...'; $stdout.flush

window('Basic Image', 96, 96) {
  area {
    on_draw do |area_draw_params|
      shape_maps.each do |shape_map|
        path {
          rectangle(shape_map[:x], shape_map[:y], shape_map[:width], shape_map[:height])

          fill shape_map[:color]
        }
      end
    end
  }
}.show
```

## Basic Transform

[examples/basic_transform.rb](/examples/basic_transform.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_transform.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_transform'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-transform.png](/images/glimmer-dsl-libui-mac-basic-transform.png) | ![glimmer-dsl-libui-windows-basic-transform.png](/images/glimmer-dsl-libui-windows-basic-transform.png) | ![glimmer-dsl-libui-linux-basic-transform.png](/images/glimmer-dsl-libui-linux-basic-transform.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Basic Transform', 350, 350) {
  area {
    square(0, 0, 350) {
      fill r: 255, g: 255, b: 0
    }
    40.times do |n|
      square(0, 0, 100) {
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
```

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2:

```ruby
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
```

## Basic Draw Text

[examples/basic_draw_text.rb](/examples/basic_draw_text.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_draw_text.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_draw_text'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-draw-text.png](/images/glimmer-dsl-libui-mac-basic-draw-text.png) | ![glimmer-dsl-libui-windows-basic-draw-text.png](/images/glimmer-dsl-libui-windows-basic-draw-text.png) | ![glimmer-dsl-libui-linux-basic-draw-text.png](/images/glimmer-dsl-libui-linux-basic-draw-text.png)

[LibUI](https://github.com/kojix2/LibUI) Original Version:

```ruby
require 'libui'

UI = LibUI

UI.init

handler = UI::FFI::AreaHandler.malloc
area    = UI.new_area(handler)

# Michael Ende (1929-1995)
# The Neverending Story is a fantasy novel by German writer Michael Ende,
# The English version, translated by Ralph Manheim, was published in 1983.

TITLE = 'Michael Ende (1929-1995) The Neverending Story'

str1 = \
  '  At last Ygramul sensed that something was coming toward ' \
  'her. With the speed of lightning, she turned about, confronting ' \
  'Atreyu with an enormous steel-blue face. Her single eye had a ' \
  'vertical pupil, which stared at Atreyu with inconceivable malignancy. '

str2 = \
  '  A cry of fear escaped Bastian. '

str3 = \
  '  A cry of terror passed through the ravine and echoed from ' \
  'side to side. Ygramul turned her eye to left and right, to see if ' \
  'someone else had arrived, for that sound could not have been ' \
  'made by the boy who stood there as though paralyzed with ' \
  'horror. '

str4 = \
  '  Could she have heard my cry? Bastion wondered in alarm. ' \
  "But that's not possible. "

str5 = \
  '  And then Atreyu heard Ygramuls voice. It was very high ' \
  'and slightly hoarse, not at all the right kind of voice for that ' \
  'enormous face. Her lips did not move as she spoke. It was the ' \
  'buzzing of a great swarm of hornets that shaped itself into ' \
  'words. '

str = ''
attr_str = UI.new_attributed_string(str)

def attr_str.append(what, color)
  case color
  when :red
    color_attribute = UI.new_color_attribute(0.0, 0.5, 0.0, 0.7)
  when :green
    color_attribute = UI.new_color_attribute(0.5, 0.0, 0.25, 0.7)
  end
  start = UI.attributed_string_len(self)
  UI.attributed_string_append_unattributed(self, what)
  UI.attributed_string_set_attribute(self, color_attribute, start, start + what.size)
  UI.attributed_string_append_unattributed(self, "\n\n")
end

attr_str.append(str1, :green)
attr_str.append(str2, :red)
attr_str.append(str3, :green)
attr_str.append(str4, :red)
attr_str.append(str5, :green)

Georgia = 'Georgia'

handler_draw_event = Fiddle::Closure::BlockCaller.new(0, [1, 1, 1]) do |_, _, adp|
  area_draw_params = UI::FFI::AreaDrawParams.new(adp)
  default_font = UI::FFI::FontDescriptor.malloc
  default_font.Family = Georgia
  default_font.Size = 13
  default_font.Weight = 500
  default_font.Italic = 0
  default_font.Stretch = 4
  params = UI::FFI::DrawTextLayoutParams.malloc

  # UI.font_button_font(font_button, default_font)
  params.String = attr_str
  params.DefaultFont = default_font
  params.Width = area_draw_params.AreaWidth
  params.Align = 0
  text_layout = UI.draw_new_text_layout(params)
  UI.draw_text(area_draw_params.Context, text_layout, 0, 0)
  UI.draw_free_text_layout(text_layout)
end

handler.Draw         = handler_draw_event
# Assigning to local variables
# This is intended to protect Fiddle::Closure from garbage collection.
handler.MouseEvent   = (c1 = Fiddle::Closure::BlockCaller.new(0, [0]) {})
handler.MouseCrossed = (c2 = Fiddle::Closure::BlockCaller.new(0, [0]) {})
handler.DragBroken   = (c3 = Fiddle::Closure::BlockCaller.new(0, [0]) {})
handler.KeyEvent     = (c4 = Fiddle::Closure::BlockCaller.new(0, [0]) {})

box = UI.new_vertical_box
UI.box_set_padded(box, 1)
UI.box_append(box, area, 1)

main_window = UI.new_window(TITLE, 600, 400, 1)
UI.window_set_margined(main_window, 1)
UI.window_set_child(main_window, box)

UI.window_on_closing(main_window) do
  UI.control_destroy(main_window)
  UI.quit
  0
end
UI.control_show(main_window)

UI.main
UI.quit
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

# Michael Ende (1929-1995)
# The Neverending Story is a fantasy novel by German writer Michael Ende,
# The English version, translated by Ralph Manheim, was published in 1983.
class BasicDrawText
  include Glimmer
  
  def alternating_color_string(initial: false, &block)
    @index = 0 if initial
    @index += 1
    string {
      if @index.odd?
        color r: 0.5, g: 0, b: 0.25, a: 0.7
      else
        color r: 0, g: 0.5, b: 0, a: 0.7
      end
      
      block.call + "\n\n"
    }
  end
  
  def launch
    window('Michael Ende (1929-1995) The Neverending Story', 600, 400) {
      margined true
      
      area {
        text { # default arguments for x, y, and width are (0, 0, area_draw_params[:area_width])
          # align :left # default alignment
          default_font family: 'Georgia', size: 13, weight: :medium, italic: :normal, stretch: :normal
            
          alternating_color_string(initial: true) {
            '  At last Ygramul sensed that something was coming toward ' \
            'her. With the speed of lightning, she turned about, confronting ' \
            'Atreyu with an enormous steel-blue face. Her single eye had a ' \
            'vertical pupil, which stared at Atreyu with inconceivable malignancy. '
          }
          alternating_color_string {
            '  A cry of fear escaped Bastian. '
          }
          alternating_color_string {
            '  A cry of terror passed through the ravine and echoed from ' \
            'side to side. Ygramul turned her eye to left and right, to see if ' \
            'someone else had arrived, for that sound could not have been ' \
            'made by the boy who stood there as though paralyzed with ' \
            'horror. '
          }
          alternating_color_string {
            '  Could she have heard my cry? Bastion wondered in alarm. ' \
            "But that's not possible. "
          }
          alternating_color_string {
            '  And then Atreyu heard Ygramuls voice. It was very high ' \
            'and slightly hoarse, not at all the right kind of voice for that ' \
            'enormous face. Her lips did not move as she spoke. It was the ' \
            'buzzing of a great swarm of hornets that shaped itself into ' \
            'words. '
          }
        }
      }
    }.show
  end
end

BasicDrawText.new.launch
```

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version 2:

```ruby
require 'glimmer-dsl-libui'

# Michael Ende (1929-1995)
# The Neverending Story is a fantasy novel by German writer Michael Ende,
# The English version, translated by Ralph Manheim, was published in 1983.
class BasicDrawText
  include Glimmer
  
  def alternating_color_string(initial: false, &block)
    @index = 0 if initial
    @index += 1
    string {
      if @index.odd?
        color r: 0.5, g: 0, b: 0.25, a: 0.7
      else
        color r: 0, g: 0.5, b: 0, a: 0.7
      end
      
      block.call + "\n\n"
    }
  end
  
  def launch
    window('Michael Ende (1929-1995) The Neverending Story', 600, 400) {
      margined true
      
      area {
        on_draw do |area_draw_params|
          text { # default arguments for x, y, and width are (0, 0, area_draw_params[:area_width])
            # align :left # default alignment
            default_font family: 'Georgia', size: 13, weight: :medium, italic: :normal, stretch: :normal
              
            alternating_color_string(initial: true) {
              '  At last Ygramul sensed that something was coming toward ' \
              'her. With the speed of lightning, she turned about, confronting ' \
              'Atreyu with an enormous steel-blue face. Her single eye had a ' \
              'vertical pupil, which stared at Atreyu with inconceivable malignancy. '
            }
            alternating_color_string {
              '  A cry of fear escaped Bastian. '
            }
            alternating_color_string {
              '  A cry of terror passed through the ravine and echoed from ' \
              'side to side. Ygramul turned her eye to left and right, to see if ' \
              'someone else had arrived, for that sound could not have been ' \
              'made by the boy who stood there as though paralyzed with ' \
              'horror. '
            }
            alternating_color_string {
              '  Could she have heard my cry? Bastion wondered in alarm. ' \
              "But that's not possible. "
            }
            alternating_color_string {
              '  And then Atreyu heard Ygramuls voice. It was very high ' \
              'and slightly hoarse, not at all the right kind of voice for that ' \
              'enormous face. Her lips did not move as she spoke. It was the ' \
              'buzzing of a great swarm of hornets that shaped itself into ' \
              'words. '
            }
          }
        end
      }
    }.show
  end
end

BasicDrawText.new.launch
```

## Basic Code Area

[examples/basic_code_area.rb](/examples/basic_code_area.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_code_area.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_code_area'"
```

Mac | Windows | Linux
----|---------|------
![glimmer-dsl-libui-mac-basic-code-area.png](/images/glimmer-dsl-libui-mac-basic-code-area.png) | ![glimmer-dsl-libui-windows-basic-code-area.png](/images/glimmer-dsl-libui-windows-basic-code-area.png) | ![glimmer-dsl-libui-linux-basic-code-area.png](/images/glimmer-dsl-libui-linux-basic-code-area.png)

New [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

class BasicCodeArea
  include Glimmer::LibUI::Application
  
  before_body do
    @code = <<~CODE
      # Greets target with greeting
      def greet(greeting: 'Hello', target: 'World')
        
        puts "\#{greeting}, \#{target}!"
      end
      
      greet
      greet(target: 'Robert')
      greet(greeting: 'Aloha')
      greet(greeting: 'Aloha', target: 'Nancy')
      greet(greeting: 'Howdy', target: 'Doodle')
    CODE
  end
  
  body {
    window('Basic Code Area', 400, 300) {
      margined true
      
      code_area(language: 'ruby', code: @code)
    }
  }
end

BasicCodeArea.launch
```
