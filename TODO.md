# TODO

## Next

- Support `tab` and `tab_item`

## Soon

- Make listener block provide Ruby proxy object as optional argument (not Fiddle pointer)
- Support splatting items array for radiobuttons, editable_checkbox and checkbox items
- Support passing boolean values to C bool args/properties that take 1 or 0
- Support `non_wrapping_multiline_entry` propeties/operations via `LibUI.multiline_entry_*` methods (enhancing them to accept Ruby objects in addition to pointers)
- Document control-specific operations
- Consider making `padded 1` the default in `horizontal_box` and `vertical_box` to achieve nicer looking GUI by default
- Consider making `margined 1` the default in `window`, `tab`, and `group` to achieve nicer looking GUI by default
- Enhance `box_append` methods to accept Ruby objects in addition to pointers
- Support `non_wrapping_multiline_entry` properties/operations via `multiline_entry` libui_api_keyword

## Future

- Support examples/basic_area.rb
- Support examples/basic_draw_text.rb
- Support examples/basic_table.rb
- Support examples/basic_table_image.rb
- Support examples/date_time_picker.rb
- Support examples/font_button.rb
- Support examples/histogram.rb
- Support ability to set properties on a control after instantiating without args (e.g. `window { title 'Title'; width 300; height 400; has_menubar true }`)
- Support data-binding
