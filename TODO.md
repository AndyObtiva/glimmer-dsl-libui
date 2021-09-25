# TODO

## Next

- Support table `button_column`
- Support automatic table cell value reading management (row deletion in `cell_rows`)

## Soon

- New examples/deletable_row_table.rb
- Support automatic table cell value reading management (row insertion in `cell_rows`)
- New examples/insertable_row_table.rb
- Support automatic table cell value reading management (row change in `cell_rows`)
- New examples/changable_row_table.rb
- Support table `checkbox_column`
- Support table `checkbox_text_column`
- Support table `progress_bar_column`

## Future

- Support examples/basic_area.rb
- Support examples/basic_draw_text.rb
- Support examples/histogram.rb
- Support general property data-binding
- Support table data-binding
- Support combobox and editable_combobox property data-binding
- Support radio_buttons property data-binding
- Create new examples not found in LibUI for everything not covered by the original examples
- Support control-specific operations that accept Ruby proxy objects instead of Fiddle pointer objects (mainly `insert_at` operations)
- Support automatic `grid` horizontal or vertical layout by specifying `column_count` or `row_count`
- Support re-opening a control by using `#content`
- Support custom controls
- Support custom windows
- Add a 3rd tab to examples/grid.rb showcasing the halign and valign properties and provide symbol alternatives for their values like `:fill` and `:center`

## Maybe

- Trap exit signal (CTRL+C) and close application gracefully
- Support optionally passing arguments to columns for LibUI.append_column_xyz methods
- Support `table` `on_changed` listener to intercept change and cancel it if needed
