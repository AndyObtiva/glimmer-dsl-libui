# [<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=85 />](https://github.com/AndyObtiva/glimmer) Glimmer DSL for LibUI 0.0.1
## Dependency-Free Ruby Desktop Development GUI Library
[![Gem Version](https://badge.fury.io/rb/glimmer-dsl-libui.svg)](http://badge.fury.io/rb/glimmer-dsl-libui)
[![Maintainability](https://api.codeclimate.com/v1/badges/ce2853efdbecf6ebdc73/maintainability)](https://codeclimate.com/github/AndyObtiva/glimmer-dsl-libui/maintainability)
[![Join the chat at https://gitter.im/AndyObtiva/glimmer](https://badges.gitter.im/AndyObtiva/glimmer.svg)](https://gitter.im/AndyObtiva/glimmer?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[Glimmer DSL for LibUI](https://rubygems.org/gems/glimmer-dsl-libui) is a dependency-free Ruby desktop development GUI library. No need to pre-install any pre-requisites. Just install the gem and have platform-independent GUI that just works!

[Glimmer DSL for LibUI](https://github.com/AndyObtiva/glimmer-dsl-libui) aims to provide a DSL similar to the [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) to enable more productive desktop development in Ruby with:
- Declarative DSL syntax that visually maps to the GUI widget hierarchy
- Convention over configuration via smart defaults and automation of low-level details
- Requiring the least amount of syntax possible to build GUI
- Bidirectional Data-Binding to declaratively wire and automatically synchronize GUI with Business Models
- Custom Widget support
- Scaffolding for new custom widgets, apps, and gems
- Native-Executable packaging on Mac, Windows, and Linux

## Glimmer GUI DSL Concepts

The Glimmer GUI DSL provides a declarative syntax for [LibUI](https://github.com/kojix2/LibUI) that:
- Supports smart defaults (e.g. automatic `on_closing` listener that quits `window`)
- Automates wiring of widgets (e.g. `button` is automatically set as child of `window`)
- Hides lower-level details (e.g. `LibUI.main` loop is started automatically when triggering `show` on `window`)
- Nests widgets according to their visual hierarchy
- Requires the minimum amount of syntax needed to describe an app's GUI

The Glimmer GUI DSL follows these simple concepts in mapping from [LibUI](https://github.com/kojix2/LibUI) syntax:
- **Control**: [LibUI](https://github.com/kojix2/LibUI) controls may be declared by lower-case underscored name (aka keyword) (e.g. `window` or `button`). Behind the scenes, they are represented by keyword methods that map to corresponding `LibUI.new_keyword` methods receiving args (e.g. `window('hello world', 300, 200, 1)`).
- **Content/Properties/Listeners Block**: Any keyword may be optionally followed by a Ruby curly-brace multi-line-block containing nested controls (content) and/or properties (attributes) (e.g. `window('hello world', 300, 200, 1) {button('greet')}`). It optionally recives one arg representing the control (e.g. `button('greet') {|b| on_clicked { puts b.text}}`)
- **Property**: Control properties may be declared inside keyword blocks with lower-case underscored name followed by property value args (e.g. `title "hello world"` inside `group`). Behind the scenes, they properties correspond to `control_set_property` methods.
- **Listener**: Control listeners may be declared inside keyword blocks with listener lower-case underscored name beginning with `on_` and receiving required block handler (e.g. `on_clicked {puts 'clicked'}` inside `button`). Behind the scenes, they listeners correspond to `control_on_event` methods.

Example of an app written in [LibUI](https://github.com/kojix2/LibUI)'s procedural imperative syntax:

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

Example of the same app written in [Glimmer](https://github.com/AndyObtiva/glimmer) object-oriented declarative hierarchical syntax:

```ruby
require 'glimmer-dsl-libui'

include Glimmer

window('hello world', 300, 200, 1) {
  on_closing do
    puts 'Bye Bye'
  end
}.show
```

## Usage

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
      
      on_closing do
        puts 'Bye Bye'
      end
    }.show
  end
end

Application.new.launch
```

## API

Any control returned by a Glimmer GUI DSL keyword declaration can be introspected for its properties and updated via object-oriented attributes (standard Ruby `attr`/`attr=` or `set_attr`).

Example (you may copy/paste in [`girb`](#girb-glimmer-irb)):

```ruby
w = window('hello world', 300, 200, 1)
puts w.title # => hello world
w.title = 'howdy'
puts w.title # => howdy
w.set_title 'aloha'
puts w.title # => aloha
```

## Girb (Glimmer IRB)

You can run the `girb` command (`bin/girb` if you cloned the project locally):

```
girb
```

This gives you `irb` with the `glimmer-dsl-libui` gem loaded and the `Glimmer` module mixed into the main object for easy experimentation with GUI.

Gotcha: On the Mac, when you close a window opened in `girb`, it remains open until you enter `exit` or open another GUI window.

## Examples

These examples reimplement the ones in the [LibUI](https://github.com/kojix2/LibUI) project utilizing the shorter Glimmer GUI DSL syntax.

### Basic Window

[examples/basic_window.rb](examples/basic_window.rb)

Mac

![glimmer-dsl-libui-basic-window-mac.png](images/glimmer-dsl-libui-basic-window-mac.png)

Linux

![glimmer-dsl-libui-basic-window-linux.png](images/glimmer-dsl-libui-basic-window-linux.png)

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

Mac

![glimmer-dsl-libui-basic-button-mac.png](images/glimmer-dsl-libui-basic-button-mac.png)
![glimmer-dsl-libui-basic-button-msg-box-mac.png](images/glimmer-dsl-libui-basic-button-msg-box-mac.png)

Linux

![glimmer-dsl-libui-basic-button-linux.png](images/glimmer-dsl-libui-basic-button-linux.png)
![glimmer-dsl-libui-basic-button-msg-box-linux.png](images/glimmer-dsl-libui-basic-button-msg-box-linux.png)

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
