# TODO

## Next

- New examples/dynamic_area2.rb (using stable paths)
- Support `figure(x = nil, y = nil) {}` (`draw_path_new_figure`)
- Support `arc` (`draw_path_arc_to` if `draw_path_new_figure` was called already or `draw_path_new_figure_with_arc` otherwise)
- Support `bezier`
- Support `line`
- Support `closed true` property inside nested figure (`draw_path_close_figure`)
- Support `path#destroy`
- Support `figure#destroy`
- Support `path_segment#destroy` (e.g. for `arc`, `bezier`, or `line`)
- Support `area` listeners: `on_mouse_event`, `on_mouse_crossed`, `on_drag_broken`, `on_key_event`
- Support `:linear_gradient` `fill`/`stroke` `:type`
- Support `:radial_gradient` `fill`/`stroke` `:type`
- Support `stroke` `:dashes`
- Support `area` `transform` property and `matrix` object

## Soon

- Support examples/histogram.rb
- New examples/search.rb

## Future

- Support examples/basic_draw_text.rb
- Support `text` control
- Support `search_entry` control
- New examples/login.rb
- Support `password_entry` control
- New examples/scrolling_area.rb
- Support `scrolling_area` control and `size` property
- Document `vertical_separator` control
- Create new examples not found in LibUI for everything not covered by the original examples
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

- Support Dynamic `path` (inside `on_draw` listener)
- Support Dynamic `text` (inside `on_draw` listener)
- Support Dynamic `matrix` (inside `on_draw` listener)
- Support Dynamic `path` `save` and `restore`
- Support nested paths in Path DSL
- Support control-specific operations that accept Ruby proxy objects instead of Fiddle pointer objects (mainly `insert_at` operations)
- Trap exit signal (CTRL+C) and close application gracefully
- Support optionally passing arguments to columns for LibUI.append_column_xyz methods
- Support `table` `on_changed` listener to intercept change and cancel it if needed
- Support `table` `cell_value` block property to do custom cell value reading along with `num_rows` property
- Support `table` `set_cell_value` block property to do custom cell value setting
- Support custom `on_destroy` listener on all widgets, not just `window`
- Support supplying optional `uiTableTextColumnOptionalParams *textParams` to `text_column`
- Support configuring `RowBackgroundColorModelColumn` in TableParams
- Support automatic table row change when performing a direct row/column update in `cell_rows` (e.g. `data[3][0] = 'new value'`) as opposed to a general row update (e.g. `data[3] = ['new value', 'other new value']` <- already supported)
- Fold menus inside a `menu_bar` control

# Refactoring

- Refactor column proxies code to be more dynamic and enable autosupport of new columns in the future
