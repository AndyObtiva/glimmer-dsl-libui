# TODO

## Next

- Support passing boolean values to C bool args/properties that take 1 or 0
  - Constructors (accept both 0/1 and boolean)
  - Property Readers (return only boolean)
  - Property Writers (accept both 0/1 and boolean)
  - Update all examples to utilize booleans
- Make `window` `has_menubar` instantiation property have the default value of `1` if not specified

## Soon

- Document control-specific operations
- Document Style Guide
- Support examples/font_button.rb
- Build a meta-example (example of examples)

## Future

- Support examples/basic_area.rb
- Support examples/basic_draw_text.rb
- Support examples/basic_table.rb
- Support examples/basic_table_image.rb
- Support examples/date_time_picker.rb
- Support examples/histogram.rb
- Create new examples not found in LibUI for everything not covered by the original examples
- Implement examples in libui_paradise
- Support ability to set properties on a control after instantiating without args (e.g. `window { title 'Title'; width 300; height 400; has_menubar true }`)
- Support data-binding
