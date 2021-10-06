# TODO

## Next

- Support `string` control property `open_type_features`

## Soon

- Support supplying optional `uiTableTextColumnOptionalParams *textParams` to `text_column`
- Support configuring `RowBackgroundColorModelColumn` in TableParams

## Future

- Support automatic `grid` horizontal or vertical layout by specifying `column_count` or `row_count`
- Support `table` `cell_value` block property to do custom cell value reading along with `num_rows` property
- Support `table` `set_cell_value` block property to do custom cell value setting
- Support automatic table row change when performing a direct row/column update in `cell_rows` (e.g. `data[3][0] = 'new value'`) as opposed to a general row update (e.g. `data[3] = ['new value', 'other new value']` <- already supported)
- Support `table` `on_changed` listener to report changes
- Support control-specific operations that accept Ruby proxy objects instead of Fiddle pointer objects (mainly `insert_at` operations)
- Support custom `on_destroy` listener on all widgets, not just `window`
- Support `path` `fill`/`stroke` `:type` of `:linear_gradient`
- Support `path` `fill`/`stroke` `:type` of `:radial_gradient`

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
- Create more advanced examples such as Tetris, Calculator, Timer, Tic Tac Toe, Connect 4, Clock, Metronome, Weather, Stock Ticker, Battleship, Game of Life

## Maybe

- Support Dynamic `path` `save` and `restore` calls
- Support nested paths/shapes in Path DSL with relative positioning
- Trap exit signal (CTRL+C) and close application gracefully (it seems using ractors or sleep causes CTRL+C to work, could be a good workaround)
- Support optionally passing arguments to columns for LibUI.append_column_xyz methods
- Support `table` `on_changing` listener to intercept change and cancel it if needed (`on_changing`)
- Fold menus inside a `menu_bar` control
- Support `matrix` `transform_point` method
- Support `matrix` `transform_size` method
- Support `matrix` operation noun names (e.g. `translation` for `translate`) to be more declarative
- Interpret characters in key event while holding a modifer down (e.g. ! for 1 + shift)
- Support animation
- Consider making all event hashes and param hashes accept retrieval of their key values through method calls not just [] calls
- Support nesting shapes directly under area to represent paths having one shape, and nesting fill/stroke within the shapes (not path)
- Consider auto-preventing app crashes (catch error) if someone mis-enters values for the GUI DSL (keeping GUI alive if possible)
- Look into use of `free_control` vs `control_destroy` especially in cases of controls for which the latter method does not work

# Refactoring

- Refactor column proxies code to be more dynamic and enable autosupport of new columns in the future
