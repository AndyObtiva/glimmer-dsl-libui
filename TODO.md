# TODO

## Next

- Make `padded 1` the default in `horizontal_box` and `vertical_box` to achieve nicer looking GUI by default
- Make `margined 1` the default in `window`, `tab`, and `group` to achieve nicer looking GUI by default

## Soon

- Support passing boolean values to C bool args/properties that take 1 or 0
- Enhance `box_append` and `{control}_set_child` methods to accept Ruby objects in addition to pointers
- Document control-specific operations
- Support examples/font_button.rb

## Future

- Create new examples not found in LibUI
- Support examples/basic_area.rb
- Support examples/basic_draw_text.rb
- Support examples/basic_table.rb
- Support examples/basic_table_image.rb
- Support examples/date_time_picker.rb
- Support examples/histogram.rb
- Support ability to set properties on a control after instantiating without args (e.g. `window { title 'Title'; width 300; height 400; has_menubar true }`)
- Support data-binding
