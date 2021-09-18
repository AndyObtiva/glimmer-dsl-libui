# TODO

## Next

- Support passing boolean values to C bool args/properties that take 1 or 0

## Soon

- Enhance `box_append` and `{control}_set_child` methods to accept Ruby objects in addition to pointers
- Destroy main window upon hitting quit on quit menu item (look for it in `ControlProxy::all_controls`)
- Auto-define `menu('File')` and `quit_menu_item` if no `menu`/`menu_item` instances were generated.
- Document control-specific operations
- Document Smart Defaults and Conventions
- Document Style Guide
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
