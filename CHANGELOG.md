# Change Log

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
