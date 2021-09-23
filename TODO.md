# TODO

## Next

- Support table `image_column`
- Support examples/basic_table_image.rb
- Support `image` and `image_part` for building images from rgba byte arrays

## Soon

- Support table `image_text_columns`
- New examples/basic_table_image_text.rb
- Support table `button_column`
- Support automatic table cell value reading management (row deletion in `cell_rows`)
- New examples/deletable_row_table.rb
- Support automatic table cell value reading management (row insertion in `cell_rows`)
- New examples/insertable_row_table.rb
- Support automatic table cell value reading management (row change in `cell_rows`)
- New examples/changable_row_table.rb
- Support table `checkbox_column`
- Support table `checkbox_text_column`
- Support table `progress_bar_column`
- Support editable `table` control

## Future

- Support examples/basic_area.rb
- Support examples/basic_draw_text.rb
- Support examples/histogram.rb
- Create new examples not found in LibUI for everything not covered by the original examples
- Support general property data-binding
- Support table property data-binding
- Support combobox and editable_combobox property data-binding
- Support radio_buttons property data-binding
- Support control-specific operations that accept Ruby proxy objects instead of Fiddle pointer objects
- Consider supporting italic values as boolean (`true` for `2` and `false` for `0`)
- Consider fine-grained attribute reader methods for `font_button` (e.g. `family`) and `color_button` (e.g. `green`)
- Trap exit signal (CTRL+C) and close application gracefully
- Support automatic `grid` horizontal or vertical layout by specifying `column_count` or `row_count`
- Support re-opening a control by using `#content`
