# [<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=85 />](https://github.com/AndyObtiva/glimmer) Glimmer DSL for LibUI 0.0.4
## Prerequisite-Free Ruby Desktop Development GUI Library
[![Gem Version](https://badge.fury.io/rb/glimmer-dsl-libui.svg)](http://badge.fury.io/rb/glimmer-dsl-libui)
[![Maintainability](https://api.codeclimate.com/v1/badges/ce2853efdbecf6ebdc73/maintainability)](https://codeclimate.com/github/AndyObtiva/glimmer-dsl-libui/maintainability)
[![Join the chat at https://gitter.im/AndyObtiva/glimmer](https://badges.gitter.im/AndyObtiva/glimmer.svg)](https://gitter.im/AndyObtiva/glimmer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[Glimmer](https://github.com/AndyObtiva/glimmer) DSL for [LibUI](https://github.com/kojix2/LibUI) is a prerequisite-free Ruby desktop development GUI library. No need to pre-install any prerequisites. Just install the gem and have platform-independent GUI that just works!

[LibUI](https://github.com/kojix2/LibUI) is a thin [Ruby](https://www.ruby-lang.org/en/) wrapper around [libui](https://github.com/andlabs/libui), a relatively new C GUI library that renders native widgets on every platform (similar to [SWT](https://www.eclipse.org/swt/), but without the heavy weight of the [Java Virtual Machine](https://www.java.com/en/)).

The main trade-off in using [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) as opposed to [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) or [Glimmer DSL for Tk](https://github.com/AndyObtiva/glimmer-dsl-tk) is the fact that [SWT](https://www.eclipse.org/swt/) and [Tk](https://www.tcl.tk/) are more mature than mid-alpha [libui](https://github.com/andlabs/libui) as GUI toolkits. Still, if there is only a need to build a small simple application, [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) could be a good convenient choice due to having zero prerequisites beyond the dependencies included in the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui). Also, just like [Glimmer DSL for Tk](https://github.com/AndyObtiva/glimmer-dsl-tk), its apps start instantly and have a small memory footprint. [LibUI](https://github.com/kojix2/LibUI) is a promising new GUI toolkit that might prove quite worthy in the future.

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) aims to provide a DSL similar to the [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) to enable more productive desktop development in Ruby with:
- Declarative DSL syntax that visually maps to the GUI widget hierarchy
- Convention over configuration via smart defaults and automation of low-level details
- Requiring the least amount of syntax possible to build GUI
- Bidirectional Data-Binding to declaratively wire and automatically synchronize GUI with Business Models
- Custom Widget support
- Scaffolding for new custom widgets, apps, and gems
- Native-Executable packaging on Mac, Windows, and Linux

Example:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('hello world', 300, 200, 1).show
```

![glimmer-dsl-libui-mac-basic-window.png](images/glimmer-dsl-libui-mac-basic-window.png)
![glimmer-dsl-libui-linux-basic-window.png](images/glimmer-dsl-libui-linux-basic-window.png)

NOTE: [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) is in early alpha mode (only supports included examples). Please help make better by contributing, adopting for small or low risk projects, and providing feedback. It is still an early alpha, so the more feedback and issues you report the better.

Other [Glimmer](https://rubygems.org/gems/glimmer) DSL gems you might be interested in:
- [glimmer-dsl-swt](https://github.com/AndyObtiva/glimmer-dsl-swt): Glimmer DSL for SWT (JRuby Desktop Development GUI Framework)
- [glimmer-dsl-opal](https://github.com/AndyObtiva/glimmer-dsl-opal): Glimmer DSL for Opal (Pure Ruby Web GUI and Auto-Webifier of Desktop Apps)
- [glimmer-dsl-xml](https://github.com/AndyObtiva/glimmer-dsl-xml): Glimmer DSL for XML (& HTML)
- [glimmer-dsl-css](https://github.com/AndyObtiva/glimmer-dsl-css): Glimmer DSL for CSS
- [glimmer-dsl-tk](https://github.com/AndyObtiva/glimmer-dsl-tk): Glimmer DSL for Tk (MRI Ruby Desktop Development GUI Library)

## Glimmer GUI DSL Concepts

The Glimmer GUI DSL provides object-oriented declarative hierarchical syntax for [LibUI](https://github.com/kojix2/LibUI) that:
- Supports smart defaults (e.g. automatic `on_closing` listener that quits `window`)
- Automates wiring of widgets (e.g. `button` is automatically set as child of `window`)
- Hides lower-level details (e.g. `LibUI.main` loop is started automatically when triggering `show` on `window`)
- Nests widgets according to their visual hierarchy
- Requires the minimum amount of syntax needed to describe an app's GUI

The Glimmer GUI DSL follows these simple concepts in mapping from [LibUI](https://github.com/kojix2/LibUI) syntax:
- **Control**: [LibUI](https://github.com/kojix2/LibUI) controls may be declared by lower-case underscored name (aka keyword) (e.g. `window` or `button`). Behind the scenes, they are represented by keyword methods that map to corresponding `LibUI.new_keyword` methods receiving args (e.g. `window('hello world', 300, 200, 1)`).
- **Content/Properties/Listeners Block**: Any keyword may be optionally followed by a Ruby curly-brace multi-line-block containing nested controls (content) and/or properties (attributes) (e.g. `window('hello world', 300, 200, 1) {button('greet')}`). It optionally recives one arg representing the control (e.g. `button('greet') {|b| on_clicked { puts b.text}}`)
- **Property**: Control properties may be declared inside keyword blocks with lower-case underscored name followed by property value args (e.g. `title "hello world"` inside `group`). Behind the scenes, properties correspond to `control_set_property` methods.
- **Listener**: Control listeners may be declared inside keyword blocks with listener lower-case underscored name beginning with `on_` and receiving required block handler (e.g. `on_clicked {puts 'clicked'}` inside `button`). Behind the scenes, listeners correspond to `control_on_event` methods.

Example of an app written in [LibUI](https://github.com/kojix2/LibUI)'s procedural imperative syntax:

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

Example of the same app written in [Glimmer](https://github.com/AndyObtiva/glimmer) object-oriented declarative hierarchical syntax:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('hello world', 300, 200, 1) { |w|
  button('Button') {
    on_clicked do
      msg_box(w, 'Information', 'You clicked the button')
    end
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

## Usage

Install [glimmer-dsl-libui](https://rubygems.org/gems/glimmer-dsl-libui) gem directly:

```
gem install glimmer-dsl-libui
```
 
Or install via Bundler `Gemfile`:

```ruby
gem 'glimmer-dsl-libui', '~> 0.0.4'
```

Add `require 'glimmer-dsl-libui'` at the top, and then `include Glimmer` into the top-level main object for testing or into an actual class for serious usage.

Example (you may copy/paste in [`girb`](#girb-glimmer-irb)):

```ruby
require 'glimmer-dsl-libui'

class Application
  include Glimmer
  
  def launch
    window('hello world', 300, 200, 1) {
      button('Button') {
        on_clicked do
          puts 'Button Clicked'
        end
      }
    }.show
  end
end

Application.new.launch
```

## API

Any control returned by a [Glimmer GUI DSL](#glimmer-gui-dsl-concepts) keyword declaration can be introspected for its properties and updated via object-oriented attributes (standard Ruby `attr`/`attr=` or `set_attr`).

Example (you may copy/paste in [`girb`](#girb-glimmer-irb)):

```ruby
w = window('hello world', 300, 200, 1)
puts w.title # => hello world
w.title = 'howdy'
puts w.title # => howdy
w.set_title 'aloha'
puts w.title # => aloha
```

Controls are wrapped as Ruby proxy objects, having a `#libui` method to obtain the wrapped Fiddle pointer object. Ruby proxy objects rely on composition (via [Proxy Design Pattern](https://en.wikipedia.org/wiki/Proxy_pattern)) instead of inheritance to shield consumers from having to deal with lower-level details unless absolutely needed.

Example (you may copy/paste in [`girb`](#girb-glimmer-irb)):

```ruby
w = window('hello world', 300, 200, 1) # => #<Glimmer::LibUI::WindowProxy:0x00007fde4ea39fb0
w.libui # => #<Fiddle::Pointer:0x00007fde53997980 ptr=0x00007fde51352a60 size=0 free=0x0000000000000000>
```

Supported Controls and their Properties / Listeners:
- `button`: `text` (`String`) / `on_clicked`
- `combobox`: `items` (`Array` of `String`), `selected` (`1` or `0`) / `on_selected`
- `entry`: `read_only` (`1` or `0`), `text` (`String`) / `on_changed`
- `horizontal_box`: None / None
- `menu`: None / None
- `menu_item`: `checked` (`1` or `0`) / `on_clicked`
- `msg_box`: None / None
- `non_wrapping_multiline_entry`: None / None
- `vertical_box`: None / None
- `window`: `borderless` (`1` or `0`), `content_size` (width `Numeric`, height `Numeric`), `fullscreen` (`1` or `0`), `margined` (`1` or `0`), `title` (`String`) / `on_closing`, `on_content_size_changed`

Common Control Properties:
- `enabled` [read-only] (`1` or `0`)
- `libui` (`Fiddle::Pointer`): returns wrapped [LibUI](https://github.com/kojix2/LibUI) object
- `parent_proxy` (`Glimmer::LibUI::ControlProxy` or subclass)
- `parent` (`Fiddle::Pointer`)
- `toplevel` [read-only] (`1` or `0`)
- `visible` [read-only] (`1` or `0`)
- `stretchy` [dsl-only] (`1` or `0`): available in [Glimmer GUI DSL](#glimmer-gui-dsl-concepts) when nested under `horizontal_box` or `vertical_box`

Common Control Operations:
- `destroy`
- `disable`
- `enable`
- `hide`
- `show`

To learn more about the [LibUI](https://github.com/kojix2/LibUI) API exposed through [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui), check out the [libui C headers](https://github.com/andlabs/libui/blob/master/ui.h)

## Girb (Glimmer IRB)

You can run the `girb` command (`bin/girb` if you cloned the project locally):

```
girb
```

This gives you `irb` with the `glimmer-dsl-libui` gem loaded and the `Glimmer` module mixed into the main object for easy experimentation with GUI.

Gotcha: On the Mac, when you close a window opened in `girb`, it remains open until you enter `exit` or open another GUI window.

## Examples

These examples reimplement the ones in the [LibUI](https://github.com/kojix2/LibUI) project utilizing the [Glimmer GUI DSL](#glimmer-gui-dsl-concepts).

### Basic Window

[examples/basic_window.rb](examples/basic_window.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_window.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_window'"
```

Mac

![glimmer-dsl-libui-mac-basic-window.png](images/glimmer-dsl-libui-mac-basic-window.png)

Linux

![glimmer-dsl-libui-linux-basic-window.png](images/glimmer-dsl-libui-linux-basic-window.png)

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

window('hello world', 300, 200, 1) {
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

### Basic Button

[examples/basic_button.rb](examples/basic_button.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_button.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_button'"
```

Mac

![glimmer-dsl-libui-mac-basic-button.png](images/glimmer-dsl-libui-mac-basic-button.png)
![glimmer-dsl-libui-mac-basic-button-msg-box.png](images/glimmer-dsl-libui-basic-button-msg-box.png)

Linux

![glimmer-dsl-libui-linux-basic-button.png](images/glimmer-dsl-libui-linux-basic-button.png)
![glimmer-dsl-libui-linux-basic-button-msg-box.png](images/glimmer-dsl-libui-linux-basic-button-msg-box.png)

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

window('hello world', 300, 200, 1) { |w|
  button('Button') {
    on_clicked do
      msg_box(w, 'Information', 'You clicked the button')
    end
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

### Basic Entry

[examples/basic_entry.rb](examples/basic_entry.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/basic_entry.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/basic_entry'"
```

Mac

![glimmer-dsl-libui-mac-basic-entry.png](images/glimmer-dsl-libui-mac-basic-entry.png)
![glimmer-dsl-libui-mac-basic-entry-msg-box.png](images/glimmer-dsl-libui-mac-basic-entry-msg-box.png)

Linux

![glimmer-dsl-libui-linux-basic-entry.png](images/glimmer-dsl-libui-linux-basic-entry.png)
![glimmer-dsl-libui-linux-basic-entry-msg-box.png](images/glimmer-dsl-libui-linux-basic-entry-msg-box.png)

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

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('Basic Entry', 300, 50, 1) { |w|
  horizontal_box {
    e = entry {
      # stretchy 1 # Smart default option for appending to horizontal_box
    
      on_changed do
        puts e.text
        $stdout.flush # For Windows
      end
    }
    
    button('Button') {
      stretchy 0
      
      on_clicked do
        text = e.text
        msg_box(w, 'You entered', text)
      end
    }
  }
  
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

### Simple Notepad

[examples/simple_notepad.rb](examples/simple_notepad.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/simple_notepad.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/simple_notepad'"
```

Mac

![glimmer-dsl-libui-mac-simple-notepad.png](images/glimmer-dsl-libui-mac-simple-notepad.png)

Linux

![glimmer-dsl-libui-linux-simple-notepad.png](images/glimmer-dsl-libui-linux-simple-notepad.png)

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

window('Notepad', 500, 300, 1) {
  on_closing do
    puts 'Bye Bye'
  end
  
  vertical_box {
    non_wrapping_multiline_entry
  }
}.show
```

### Midi Player

This example has prerequisites:
- Install [TiMidity](http://timidity.sourceforge.net) and ensure `timidity` command is in `PATH` (can be installed via [Homebrew](https://brew.sh) on Mac or [apt-get](https://help.ubuntu.com/community/AptGet/Howto) on Linux).
- Add `*.mid` files to `~/Music` directory (you may copy the ones included in [sounds](sounds) directory)

[examples/midi_player.rb](examples/midi_player.rb)

Run with this command from the root of the project if you cloned the project:

```
ruby -r './lib/glimmer-dsl-libui' examples/midi_player.rb
```

Run with this command if you installed the [Ruby gem](https://rubygems.org/gems/glimmer-dsl-libui):

```
ruby -r glimmer-dsl-libui -e "require 'examples/midi_player'"
```

Mac

![glimmer-dsl-libui-mac-midi-player.png](images/glimmer-dsl-libui-mac-midi-player.png)
![glimmer-dsl-libui-mac-midi-player-version-msg-box.png](images/glimmer-dsl-libui-mac-midi-player-version-msg-box.png)

Linux

![glimmer-dsl-libui-linux-midi-player.png](images/glimmer-dsl-libui-linux-midi-player.png)
![glimmer-dsl-libui-linux-midi-player-version-msg-box.png](images/glimmer-dsl-libui-linux-midi-player-version-msg-box.png)

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
      if @th.alive?
        Process.kill(:SIGKILL, @pid)
        @pid = nil
      else
        @pid = nil
      end
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

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) Version:

```ruby
require 'glimmer-dsl-libui'

class TinyMidiPlayer
  include Glimmer
  
  VERSION = '0.0.1'

  def initialize
    @pid = nil
    @music_directory = File.expand_path(ARGV[0] || '~/Music/')
    @midi_files      = Dir.glob(File.join(@music_directory, '**/*.mid'))
                          .sort_by { |path| File.basename(path) }
    at_exit { stop_midi }
    create_gui
  end

  def stop_midi
    if @pid
      if @th.alive?
        Process.kill(:SIGKILL, @pid)
        @pid = nil
      else
        @pid = nil
      end
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
    msg_box(main_window,
               'Tiny Midi Player',
               "Written in Ruby\n" \
               "https://github.com/kojix2/libui\n" \
               "Version #{VERSION}")
  end

  def create_gui
    menu('Help') { |m|
      menu_item('Version') {
        on_clicked do
          show_version(@main_window)
        end
      }
    }
    @main_window = window('Tiny Midi Player', 200, 50, 1) {
      horizontal_box {
        vertical_box {
          stretchy 0
          
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
    }
    @main_window.show
  end
end

TinyMidiPlayer.new
```

## Contributing to glimmer-dsl-libui

-   Check out the latest master to make sure the feature hasn't been
    implemented or the bug hasn't been fixed yet.
-   Check out the issue tracker to make sure someone already hasn't
    requested it and/or contributed it.
-   Fork the project.
-   Start a feature/bugfix branch.
-   Commit and push until you are happy with your contribution.
-   Make sure to add tests for it. This is important so I don't break it
    in a future version unintentionally.
-   Please try not to mess with the Rakefile, version, or history. If
    you want to have your own version, or is otherwise necessary, that
    is fine, but please isolate to its own commit so I can cherry-pick
    around it.

## Help

### Issues

You may submit [issues](https://github.com/AndyObtiva/glimmer/issues) on [GitHub](https://github.com/AndyObtiva/glimmer/issues).

[Click here to submit an issue.](https://github.com/AndyObtiva/glimmer/issues)

### Chat

If you need live help, try to [![Join the chat at https://gitter.im/AndyObtiva/glimmer](https://badges.gitter.im/AndyObtiva/glimmer.svg)](https://gitter.im/AndyObtiva/glimmer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Process

[Glimmer Process](https://github.com/AndyObtiva/glimmer/blob/master/PROCESS.md)

## Planned Features and Feature Suggestions

These features have been planned or suggested. You might see them in a future version of [Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui). You are welcome to contribute more feature suggestions.

[TODO.md](TODO.md)

## Change Log

[CHANGELOG.md](CHANGELOG.md)

## Contributors

* [Andy Maleh](https://github.com/AndyObtiva) (Founder)

[Click here to view contributor commits.](https://github.com/AndyObtiva/glimmer-dsl-libui/graphs/contributors)

## License

[MIT](LICENSE.txt)

Copyright (c) 2021 Andy Maleh

--

[<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 />](https://github.com/AndyObtiva/glimmer) Built for [Glimmer](https://github.com/AndyObtiva/glimmer) (DSL Framework).
