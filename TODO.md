# TODO

## Next

- Support `color_button` `color` property
- New examples/basic_color.rb

## Soon

- Make code text in meta_example.rb editable with launch button taking changes into account to enable experimentation

## Future

- Support `date_picker` and `time_picker` `time` property
- Support examples/date_time_picker.rb
- Support examples/basic_area.rb
- Support examples/basic_draw_text.rb
- Support examples/basic_table.rb
- Support examples/basic_table_image.rb
- Support examples/histogram.rb
- New examples/grid.rb
- New examples/form.rb
- Create new examples not found in LibUI for everything not covered by the original examples
- Implement examples in libui_paradise
- Support ability to set properties on a control after instantiating without args (e.g. `window { title 'Title'; width 300; height 400; has_menubar true }`)
- Support data-binding
- Support control-specific operations that accept Ruby proxy objects instead of Fiddle pointer objects
- Better management of `LibUI.init` and `LibUI.quit` to enable closing an app and opening a new one (perhaps manage their state globally around calls to `menu` and `window` for triggering init if not triggered already)
- Consider supporting italic values as boolean (`true` for `2` and `false` for `0`)
- On the Mac only, if no menu is specified, add a File -> Quit menu item automatically (and remove File -> Quit from Meta-Sample)
- Consider fine-grained attribute reader methods for `font_button` (e.g. `family`) and `color_button` (e.g. `green`)
