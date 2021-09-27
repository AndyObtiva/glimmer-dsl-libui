# TODO

## Next

- Support automatic table row change when performing a direct row/column update in `cell_rows` (e.g. `data[3][0] = 'new value'`)

## Soon

- Support examples/basic_area.rb

## Future

- Support examples/basic_draw_text.rb
- Support examples/histogram.rb
- Support `search_entry` control
- Support `password_entry` control
- Support `area` control
- Support `scrolling_area` control
- Document `vertical_separator` control
- Create new examples not found in LibUI for everything not covered by the original examples
- Support re-opening a control by using `#content`
- Add a 3rd tab to examples/grid.rb showcasing the halign and valign properties and provide symbol alternatives for their values like `:fill` and `:center`
- Default values for msg_box/msg_box_error args if not supplied

## Far Future
- Support general property data-binding
- Support table data-binding
- Support combobox and editable_combobox property data-binding
- Support radio_buttons property data-binding
- Support automatic `grid` horizontal or vertical layout by specifying `column_count` or `row_count`
- Support custom controls
- Support custom windows

## Maybe

- Support control-specific operations that accept Ruby proxy objects instead of Fiddle pointer objects (mainly `insert_at` operations)
- Trap exit signal (CTRL+C) and close application gracefully
- Support optionally passing arguments to columns for LibUI.append_column_xyz methods
- Support `table` `on_changed` listener to intercept change and cancel it if needed
- Support custom `on_destroy` listener on all widgets, not just `window`
- Support supplying optional `uiTableTextColumnOptionalParams *textParams` to `text_column`
- Support configuring `RowBackgroundColorModelColumn` in TableParams

# Refactoring

- Refactor column proxies code to be more dynamic and enable autosupport of new columns in the future
