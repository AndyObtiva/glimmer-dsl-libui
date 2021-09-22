# TODO

## Next

- New examples/grid.rb

## Soon

- New examples/form.rb

## Future

- Support examples/basic_table.rb
- Support examples/basic_table_image.rb
- Support examples/basic_area.rb
- Support examples/basic_draw_text.rb
- Support examples/histogram.rb
- Create new examples not found in LibUI for everything not covered by the original examples
- Implement examples in libui_paradise
- Support ability to set properties on a control after instantiating without args (e.g. `window { title 'Title'; width 300; height 400; has_menubar true }`)
- Support general property data-binding
- Support table property data-binding
- Support combobox and editable_combobox property data-binding
- Support radio_buttons property data-binding
- Support control-specific operations that accept Ruby proxy objects instead of Fiddle pointer objects
- Better management of `LibUI.init` and `LibUI.quit` to enable closing an app and opening a new one (perhaps manage their state globally around calls to `menu` and `window` for triggering init if not triggered already)
- Consider supporting italic values as boolean (`true` for `2` and `false` for `0`)
- Consider fine-grained attribute reader methods for `font_button` (e.g. `family`) and `color_button` (e.g. `green`)
- Trap exit signal (CTRL+C) and close application gracefully
