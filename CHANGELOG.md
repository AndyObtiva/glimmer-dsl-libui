# Change Log

## 0.1.8

- Support `area` listener: `on_mouse_event`
- Support `area` listener: `on_mouse_down`
- Support `area` listener: `on_mouse_up`

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
