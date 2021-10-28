# Change Log

## 0.2.16

- Document all examples with Windows screenshots
- Fix examples/basic_transform.rb issue on Windows where it shows an uncentered different graphic than what is shown on Mac and Linux

## 0.2.15

- Make examples/meta_example.rb output catch up more quickly with event puts statements
- Fix examples/color_the_circles.rb on Windows (it was crashing upon losing)

## 0.2.14

- Revise examples/meta_example.rb to avoid blocking upon launching examples, thus permitting launching multiple examples at the same time
- Automatically provide shifted `:key` characters in `area_key_event` provided in `area` key listeners `on_key_event`, `on_key_down`, and `on_key_up` given that libui does not support out of the box (e.g. `!` for SHIFT+1)
- Support `message_box` as an alias for `msg_box` (and `message_box_error` for `msg_box_error` too)
- Tolerate `nil` input for any widget `String` attributes (e.g. `entry` `text` attribute)
- Fix issue regarding `arc`s and `circle`s on Windows by auto-starting a figure if not started already (on Mac and Linux that is not needed)
- Fix Color The Shapes (Circles) and rename back to Color The Circles due to fixing `circle` support on Windows

## 0.2.13

- Rename examples/color_the_circles.rb to examples/color_the_shapes.rb to fix/make compatible with Windows by rendering only Squares on Windows, but Squares and Circles on Mac/Linux
- Fix examples/basic_table_button.rb double-deletion issue on Windows via a temporary workaround (generating an extra empty row on Windows only)
- Fix examples/basic_table_checkbox.rb , examples/basic_table_checkbox_text.rb , and examples/basic_table_color.rb on Windows
- Fix examples/basic_table_progress_bar.rb crash due to an issue on Windows when switching from -1 to a positive value
- Fix examples/area_gallery.rb (all its versions) by disabling arc/circle on Windows where they don't work due to issue in libui
- Fix girb on Windows
- Removed redundant `table` on_change notification
- Fix issue with supplying a font without all its keys (e.g. missing `:weight`) to attributed `string` nested under `text`, tolerating missing font keys.
- Fix issue with examples/color_the_circles.rb when clicking outside the playing area causing this error:
```
examples/color_the_circles.rb:82:in `block in color_circle': undefined method `include?' for nil:NilClass (NoMethodError)
        from examples/color_the_circles.rb:81:in `each'
        from examples/color_the_circles.rb:81:in `find'
        from examples/color_the_circles.rb:81:in `color_circle'
        from examples/color_the_circles.rb:212:in `block (4 levels) in launch'
```

## 0.2.12

- Upgrade to glimmer 2.4.0
- Upgrade to LibUI 0.0.12
- Support passing `string` value as an argument to attributed `string` keyword
- Support setting `string` value as a property on attributed `string` keyword (automatically redrawing)

## 0.2.11

- Fix issue with running examples that rely on local assets from gem (they work fine from locally cloned project)
- Fix issue with not showing puts output in Basic Table Button and Editable Table examples when run from Meta Example

## 0.2.10

- New examples/method_based_custom_keyword.rb
- Update examples/form.rb to have two more fields
- Update color_button example to show how to preset initial color
- Support `path` `fill`/`stroke` `:type` of `:linear_gradient`
- Support `path` `fill`/`stroke` `:type` of `:radial_gradient`
- Add text to Area Gallery examples
- Update variable names in examples/meta_example.rb to be more meaningful
- Update examples/meta_example.rb to show terminal/command-line output for run examples

## 0.2.9

- Upgrade to glimmer 2.3.0
- Use glimmer 2.3.0 to support automatic table row change when performing a direct deep row/column update in `cell_rows` (e.g. `data[3][0] = 'new value'`) as opposed to a general shallow row update (e.g. `data[3] = ['new value', 'other new value']` <- already supported)

## 0.2.8

- Support `table` `on_changed` listener to report all changes (of operation type `:deleted`, `:changed`, `:inserted`)
- Support `table` `on_edited` listener to report changes happening through direct table editing only
- Default value of `text` `width` argument looks into x and adjusts by leaving the same space on the right side

## 0.2.7

- New examples/basic_table_color.rb
- Support `background_color_column` for `table`
- Support `text_color_column` for `table`
- Support `checkbox_text_color_column` for `table`
- Support `image_text_color_column` for `table`

## 0.2.6

- Support `string` control property: `open_type_features`
- Auto-free attributed string objects from memory

## 0.2.5

- Support attributed `string` `underline_color` property (built-in enum symbols and custom color)

## 0.2.4

- Support examples/custom_draw_text.rb
- Support stable `text` control nestable under `area`
- Support `string` control property: `background`
- Support `string` control property: `font`
- Support `string` control property: `underline`
- Enhance `combobox` to accept `String` value for `selected` item instead of just `Integer` index
- Add `selected_item` read-only property to `combobox` to return selected item `String` value
- Fix `color` property support for `string` to accept 255-based rgb values
- Fix issue with alternating string colors in examples/basic_draw_text.rb

## 0.2.3

- Update examples/midi_player.rb to read sounds locally from gem
- Support examples/basic_draw_text.rb
- Support dynamic `text` control to be called in `area` `on_draw` listener
- Support `text` control `default_font` property
- Support `string` control nestable under `text` to represent an attributed/unattributed string (depending on nestable properties)
- Support `string` control property: `color`
- Support enum symbols for `align` property of `text` control
- Support enum symbols for `:italic` font descriptor key (in addition to numbers)
- Support enum symbols for `:stretch` font descriptor key (in addition to numbers)
- Support enum symbols for `:weight` font descriptor key (in addition to numbers)

## 0.2.2

- Automatically add `vertical_box` parent to `area` if it did not have a box parent (otherwise, it seems not to show up on Linux, even when directly under `grid`)

## 0.2.1

- Have examples/timer.rb show `msg_box` on finish
- Have examples/color_the_circles.rb push colored circles when colored behind uncolored circles to keep uncolored circles visible
- Fix non-blocking dialog issue on Linux with examples/color_the_circles.rb
- Support all `LibUI` methods through `Glimmer::LibUI` (with some enhanced, like `timer` and `queue_main`, which accept blocks)

## 0.2.0

- Support examples/timer.rb
- Support examples/color_the_circles.rb
- Support `timer` and `queue_main` with simple blocks through `Glimmer::LibUI.timer(time_in_seconds=0.1, repeat: true, &block)` and `Glimmer::LibUI.queue_main(&block)`
- Support `radio_menu_item` (similar to `check_menu_item`, but auto-unchecks sibling `radio_menu_item`s when checked)
- Support degrees for arc arguments (instead of radians)
- Support `circle` shape and use in examples/area_gallery.rb (all versions)
- Support `Glimmer::LibUI.x11_colors` to obtain all available X11 color symbols
- Support `#include?` method in `circle`, `rectangle`, and `square` to test containment of a point `x`,`y` coordinates

## 0.1.11

- New examples/login.rb
- Amend examples/form_table.rb with use of a `search_entry` to support table filtering
- Support `password_entry` control
- Support `search_entry` control
- Fix issue with setting control `enabled` property

## 0.1.10

- Upgrade to glimmer 2.2.1
- Add a 3rd tab to examples/grid.rb showcasing the halign and valign properties
- Support `grid` `halign`/`valign` symbol values of `:fill` (default), `:start`, `:center`, `:end`
- Add `key_value` to `area_key_event` `Hash`
- Add `ext_key_value` to `area_key_event` `Hash`

## 0.1.9

- Support `area` listener: `on_key_event`
- Support `area` listener: `on_key_down`
- Support `area` listener: `on_key_up`

## 0.1.8

- Support `area` listener: `on_mouse_event`
- Support `area` listener: `on_mouse_down`
- Support `area` listener: `on_mouse_up`
- Support `area` listener: `on_mouse_drag_start`
- Support `area` listener: `on_mouse_drag`
- Support `area` listener: `on_mouse_drop`
- Support `area` listener: `on_mouse_crossed`
- Support `area` listener: `on_mouse_enter`
- Support `area` listener: `on_mouse_exit`
- Support `area` listener: `on_drag_broken`

## 0.1.7

- Support `stroke` `:dashes` and use in examples/area_gallery.rb
- Support symbol values for draw_line_cap (`:round`, `:square`, `:flat`) and draw_line_join (`:miter`, `:round`, `:bevel`) and draw_fill_mode (`:winding` and `:alternate`)

## 0.1.6

- Update default `window` `width` to `190`
- Improve layout of examples/meta_example.rb
- Enhance examples/meta_example.rb to enable choosing versions with a spinbox instead of adding them to examples list
- Nest control proxies under `Glimmer::LibUI::ControlProxy` namespace
- Nest shapes under `Glimmer::LibUI::Shape` namespace
- Nest `vertical_box` and `horizontal_box` under `Glimmer::LibUI::ControlProxy::Box` namespace
- Nest columns under `Glimmer::LibUI::ControlProxy::Column` namespace
- Nest menu item proxies under `Glimmer::LibUI::ControlProxy::MenuItemProxy` namespace
- Nest date time picker proxies under `Glimmer::LibUI::ControlProxy::DateTimePickerProxy` namespace
- Nest multiline entry proxies under `Glimmer::LibUI::ControlProxy::MultinlineEntryProxy` namespace
- Support `time_picker` control explicitly
- Support X11 color names (via [color](https://github.com/halostatue/color) gem)
- Support passing :red, :green, :blue, :alpha keys to fill/stroke (not just :r,:g,:b,:a)
- Support 3-number hex color shorthand
- Support ability to set fill/stroke to x11/Integer/String color directly (e.g. `fill 'steelblue'` , optionally with extra hash key/value pairs e.g. `fill 0x238232, a: 0.5`)
- Support ability to set color_button.color to {color: x11/Integer/String}
- Default main_window_proxy first argument for `msg_box`/`msg_box_error` (and empty strings for following args if not passed)
- Default main_window_proxy argument for `open_file` and `save_file`

## 0.1.5

- Support examples/histogram.rb
- Support examples/basic_transform.rb
- Support `color_button` `color=`/`set_color` setter
- Switch `color_button` `color` API to return a hash of `{:r, :g, :b, :a}` instead of an array for consistency with other libui APIs (like fill and stroke brush)
- Implement `color_button` fine-grained setters (e.g. `cg.red = 144`)
- Support hex colors in `color_button` (by passing an Integer 0xFFBBAA or String hex 'ffbbaa') and `path` `fill` and `stroke` (with `:color` key)
- Eliminate need for passing `area_draw_params` to `path` when declared underneath `area` `on_draw` listener
- Support `path` `transform` property for building `matrix` objects (either through `path { transform {operations} }` directly or through `m1 = matrix {operations}; path { transform m1 }` to reuse a matrix)
- Support `area` `transform` property for building `matrix` objects (either through `area { transform {operations} }` directly or through `m1 = matrix {operations}; area { transform m1 }` to reuse a matrix)
- Ensure `matrix` `rotate` method accepts degrees (not radians)
- Support `matrix` `multiply` method that accepts a `Glimmer::LibUI::MatrixProxy` object
- Support `matrix` `invertible?` property that returns a Boolean
- Automatically reparent an `area` that is added directly under `window` with `vertical_box`. This fixes issue with display of `area` added directly under `window` in Linux.

## 0.1.4

- Update examples/basic_table_progress_bar.rb with a listener
- Set default values for shape parameters and support passing shape parameters as properties inside their body (e.g. `rectangle {x 2; y 3; width 400; height 800}`)
- New examples/area_gallery2.rb (utilizing properties instead of args)
- New examples/area_gallery3.rb (semi-declarative on_draw dynamic paths)
- New examples/area_gallery4.rb (utilizing properties instead of args with semi-declarative on_draw dynamic paths)

## 0.1.3

- New examples/area_gallery.rb
- Support `figure(x = nil, y = nil) {}` (`draw_path_new_figure`)
- Support `closed true` property inside nested figure (`draw_path_close_figure`)
- Support `line`
- Support `bezier`
- Support `arc` (`draw_path_arc_to` if `draw_path_new_figure` was called already or `draw_path_new_figure_with_arc` if parent is a figure without x,y)
- Support `square` with `x`, `y`, and `length` properties

## 0.1.2

- Support re-opening a control by using `#content {...}`
- Ensure destroying `path`/`rectangle` after drawing if it is declared inside `on_draw`
- Observe `path` `fill` and `stroke` hashes for changes and automatically redraw area accordingly
- New examples/dynamic_area2.rb (using stable paths)

## 0.1.1

- Support `area` listener: `on_draw`
- New examples/basic_area2.rb

## 0.1.0

- Support examples/basic_area.rb
- Support `area` control
- Support `path(fill_mode)` control
- Support `rectangle(x, y, width, height)` figure
- Support `path` `fill` property
- Support `path` `stroke` property

## 0.0.28

- Support automatic table row change when updating a row in `cell_rows` (e.g. `data[3] = ['new', 'row', 'cell', 'values']`)
- Support `editable` property for `checkbox_column` (checkbox editing only works in Windows due to a [libui](https://github.com/andlabs/libui) limitation)
- Support `editable`, `editable_checkbox`, and `editable_text` properties for `checkbox_text_column` (checkbox editing only works in Windows due to a [libui](https://github.com/andlabs/libui) limitation)
- Fix examples/basic_table_checkbox_text.rb by removing `editable` property

## 0.0.27

- New examples/form_table.rb
- Support automatic table row insertion upon inserting data rows into `cell_rows`

## 0.0.26

- New examples/basic_table_progress_bar.rb
- Support table `progress_bar_column`

## 0.0.25

- New examples/basic_table_checkbox_text.rb
- Support table `checkbox_text_column`

## 0.0.24

- New examples/basic_table_checkbox.rb
- Support table `checkbox_column`
- Improve support for table row deletion upon actual `cell_rows` deletion by handling multiple-row deletion not just single-row deletion

## 0.0.23

- Have `image` not require `width` and `height` if it only has one `image_part` (defaults to `image_part` `width` and `height`)
- Upgrade to LibUI version 0.0.10

## 0.0.22

- New examples/basic_table_button.rb
- Support table `button_column`
- Support table `button_column` `enabled` property
- Support `on_clicked` listener for `button_column`
- Support automatic table cell value reading management (table row deletion upon actual `cell_rows` deletion due to implicit data-binding)

## 0.0.21

- New examples/editable_column_table_image_text.rb
- Support table `image_text_column`

## 0.0.20

- New examples/editable_column_table.rb
- Support `editable` property for `text_column`

## 0.0.19

- New examples/editable_table.rb
- Support editable `table` control
- Fix issue with table `text_column` repeating the first column as the second

## 0.0.18

- Support examples/basic_table_image.rb
- Support table `image_column`
- Support `image` and `image_part` for building images from rgba byte arrays
- Rename `Glimmer::LibUI::ControlProxy.all_control_proxies` to `Glimmer::LibUI::ControlProxy.control_proxies`
- Add `Glimmer::LibUI::ControlProxy.image_proxies`

## 0.0.17

- Support examples/basic_table.rb
- Support non-editable `table` control
- Support table `text_column`
- Support table `cell_rows` property as an `Array` (rows) of `Array`s (row columns) of cell values

## 0.0.16

- Support ability to instantiate without args and set args as properties afterwards inside block (e.g. `window { title 'Greeter'; content_size 300, 400; button {text 'Greet'; on_clicked {puts 'Hi'}} }`)
  - window (was supported before, but changed default title to empty string)
  - button
  - checkbox
  - group
  - label

## 0.0.15

- New examples/form.rb
- Support `form` control and child attributes of `stretchy` and `label`
- Smart defaults for `form` child attributes `stretchy` (`true`) and `label` (`''`)

## 0.0.14

- New examples/grid.rb
- Support `grid` control and child attributes of `left`, `top`, `xspan`, `yspan`, `hexpand`, `halign`, `vexpand`, and `valign`
- Smart defaults for `grid` child attributes `left` (`0`), `top` (`0`), `xspan` (`1`), `yspan` (`1`), `hexpand` (`false`), `halign` (`0`), `vexpand` (`false`), and `valign` (`0`)

## 0.0.13

- Support examples/date_time_picker.rb
- Support `date_time_picker`, `date_picker`, and `time_picker` controls having `time`/`time=`/`set_time` property

## 0.0.12

- Have examples/meta_example.rb allow code editing to enable experimentation and learning
- Fix issue with examples/meta_example using puts_debuggerer (a development gem)

## 0.0.11

- New examples/basic_color.rb
- Support `color_button` `color` property
- Proper destroy of controls (deleting from parent `box`, `window`, or `group` first)
- On the Mac only, if no menu is specified, add a Quit menu item automatically to allow quitting with CMD+Q

## 0.0.10

- Support examples/font_button.rb
- Support `font_button` control
- Add File -> Quit menu item to examples/meta_example.rb
- Glimmer Style Guide added to README.md

## 0.0.9

- Build a meta-example (example of examples)

## 0.0.8

- Add `?` suffixed aliases to all boolean property methods
- Make C bool properties return boolean in Ruby (not `1` or `0`)
- Support passing boolean values to C bool properties in addition to `1` or `0`
- Support passing boolean values to C bool constructor args in addition to `1` or `0`
- Update all examples to utilize booleans
- Make `window` properties `title`=`'Glimmer'`, `content_size`=`150`,`150` & `has_menubar`=`1` if not specified as args in constructor
- Have string properties (e.g. `text` and `title`) return `String` not fiddle pointer

## 0.0.7

- Make `padded 1` the default in `horizontal_box` and `vertical_box` to achieve nicer looking GUI by default
- Make `margined 1` the default in `group` to achieve nicer looking GUI by default
- Destroy main window upon hitting quit on quit menu item
- Rename `ControlProxy::all_controls` to `ControlProxy::all_control_proxies` to more accurately describe its contents
- Add `ControlProxy::main_window_proxy` method to retrieve main window proxy
- Define a `#window_proxy` method on `ControlProxy` to retrieve `window` control proxy for any control

## 0.0.6

- Make listener block provide Ruby proxy object as optional argument (not Fiddle pointer)
- Handle `tab_item` scenario where it has an empty block or no block (auto-generate empty `horizontal_box` content as a smart default to avoid crashing)
- Support `non_wrapping_multiline_entry` propeties/operations via `LibUI.multiline_entry_*` methods (enhancing them to accept Ruby objects in addition to pointers)
- Support splatting `items` array for `radio_buttons`, `editable_combobox`, and `combobox` items
- Fix issue with `menu_item` `on_clicked` listeners crashing in examples/control_gallery.rb due to garbage collection

## 0.0.5

- Support examples/control_gallery.rb
- Support `open_file` and `save_file`
- Support `quit_menu_item` with `on_clicked` listener
- Support `preferences_menu_item` and `about_menu_item`
- Support `check_menu_item` and `separator_menu_item`
- Support `enabled=` & `set_enabled` on all controls (making `enabled` property read/write by relying on `enable`/`disable` operations)
- Support `visible=` & `set_visible` on all controls (making `visible` property read/write by relying on `show`/`hide` operations)
- Support `horizontal_box` and `vertical_box` propeties (`padded`) & operations (`append`, `delete`) via `LibUI.box_*` methods
- Support `editable_combobox`, `radio_buttons`, and `group`
- Support `tab` and `tab_item`
- Fix issue with always setting menu item text to 'Version' (correctly set to passed argument instead)

## 0.0.4

- Support examples/midi_player.rb
- Support `combobox` `items` attribute to append text value array declaratively
- Support `menu` and `menu_item` controls

## 0.0.3

- Support examples/simple_notepad.rb

## 0.0.2

- Support `vertical_box` and `horizontal_box`
- Support examples/basic_entry.rb

## 0.0.1

- LibUI general control and window support
- LibUI listener support
- LibUI property support
- girb (Glimmer IRB)
- Support examples/basic_window.rb
- Support examples/basic_button.rb
