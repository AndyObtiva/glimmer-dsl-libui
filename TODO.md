# TODO

## Next

- Interpret characters in key event while holding a modifer down (e.g. ! for 1 + shift)

## Soon

- New examples/basic_scrolling_area.rb
- Support `scrolling_area` control and `size` property

## Future

- New examples/search.rb
- Support `search_entry` control
- New examples/login.rb
- Support `password_entry` control
- Document `vertical_separator` control
- Add a 3rd tab to examples/grid.rb showcasing the halign and valign properties and provide symbol alternatives for their values like `:fill` (0), `:start` (1), `:center` (2), and `:end` (3)
- Support examples/basic_draw_text.rb
- Support `text` control
- Support `path` `fill`/`stroke` `:type` of `:linear_gradient`
- Support `path` `fill`/`stroke` `:type` of `:radial_gradient`
- Create new examples not found in LibUI for everything not covered by the original examples
- Support automatic `grid` horizontal or vertical layout by specifying `column_count` or `row_count`
- Support control-specific operations that accept Ruby proxy objects instead of Fiddle pointer objects (mainly `insert_at` operations)
- Support `table` `cell_value` block property to do custom cell value reading along with `num_rows` property
- Support `table` `set_cell_value` block property to do custom cell value setting
- Support custom `on_destroy` listener on all widgets, not just `window`
- Support supplying optional `uiTableTextColumnOptionalParams *textParams` to `text_column`
- Support configuring `RowBackgroundColorModelColumn` in TableParams
- Support automatic table row change when performing a direct row/column update in `cell_rows` (e.g. `data[3][0] = 'new value'`) as opposed to a general row update (e.g. `data[3] = ['new value', 'other new value']` <- already supported)
- Support `table` `on_changed` listener to report change otherwise `on_changed`

## Far Future
- Support general property data-binding
- Support table data-binding
- Support combobox and editable_combobox property data-binding
- Support radio_buttons property data-binding
- Support custom keywords representing controls, shapes, matrices, message boxes or windows
- Automate OCRA support for Windows Native-Executable Packaging
- Implement Mac Native-Executable Packaging (perhaps with https://github.com/create-dmg/create-dmg or https://github.com/sveinbjornt/Platypus)
- Scaffold an application with support for gem and native-executable packaging
- Easy Drag and Drop via `drag_source true`, `drag_and_move true`, and `on_drop { }` event

## Maybe

- Support Dynamic `path` `save` and `restore`
- Support nested paths/shapes in Path DSL with relative positioning
- Trap exit signal (CTRL+C) and close application gracefully
- Support optionally passing arguments to columns for LibUI.append_column_xyz methods
- Support `table` `on_changing` listener to intercept change and cancel it if needed (`on_changing`)
- Fold menus inside a `menu_bar` control
- Support `matrix` `transform_point` method
- Support `matrix` `transform_size` method
- Support `matrix` operation noun names (e.g. `translation` for `translate`) to be more declarative

# Refactoring

- Refactor column proxies code to be more dynamic and enable autosupport of new columns in the future
