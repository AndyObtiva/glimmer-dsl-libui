# TODO

## Next

- examples/area_drag_and_move.rb (drag around drawn objects like a house, animals, and people)
- examples/area_drag_and_drop.rb (customize a face with face parts like mustache, nose, lips, eyes, and hair)
- examples/scrolling_area_gallery.rb (note that area dimensions must be greater than its window dimensions)
- Add a second column of radio buttons to layout of meta_example to fit more examples

## Soon

- Support nesting shapes directly under `area` to represent paths having one shape, and nesting fill/stroke within the shapes (not `path`)
- Consider making all event hashes and param hashes accept retrieval of their key values through method calls not just `[key]` calls (utilize `hash-proxy` gem to solve this problem)

## Future

None

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
- Create more advanced examples such as Calculator, Connect 4, Clock, Metronome, Weather, Stock Ticker, Battleship, Game of Life

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
- Consider auto-preventing app crashes (catch error) if someone mis-enters values for the GUI DSL (keeping GUI alive if possible)
- Look into use of `free_control` vs `control_destroy` especially in cases of controls for which the latter method does not work
- Support setting image paths directly on image/image_text columns for `table` (do chunky png work internally) (look into other formats than png)
- Support automatic `grid` horizontal or vertical layout by specifying `column_count` or `row_count`
- Support custom `on_destroy` listener on all widgets, not just `window`
- Support control-specific operations that accept Ruby proxy objects instead of Fiddle pointer objects (mainly `insert_at` operations)
- Support `table` `cell_value` block property to do custom cell value reading along with `num_rows` property
- Support `table` `set_cell_value` block property to do custom cell value setting
- Use equivalents of chunky_png to support different image formats for image columns in `table`
- Fix meta-example GUI freezing after running an example until it is closed (which unfreezes meta-example)
- Automatically call `Glimmer::LibUI.queue_main` when operating on GUI from a different thread
- Override `#inspect` method for area, path, text, and/or other controls in case they contain many shapes, to prevent their printout from being too large
- Implement functionality to delay queuing area redraws until post_add_content has been called (area definition is done). Maybe offer an option to enable redrawing before area is closed too.
- Implement `bounds` property for all shapes
- Support SVG `image` control by rendering on `area`
- Support Bitmap `image` control file format
- Support row/column alternative syntax to left/top in `grid`(and maybe x/y too)
- Support `timer` keyword as shortcut for `Glimmer::LibUI.timer`
- Support `main` keyword as shortcut for `Glimmer::LibUI.queue_main`

# Refactoring

- Refactor column proxies code to be more dynamic and enable autosupport of new columns in the future
- Split attribute getter/setter methods that accept value as nil or empty with separate getter and setter methods and ensure calls to libui setters are routed to attr= methods
- Use enum symbols everwhere enum values are used directly
