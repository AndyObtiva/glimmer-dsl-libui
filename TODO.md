# TODO

## Next

- Support `color_button` `color` bidirectional data-binding (with `<=>` sign)
- Support `font_button` `font` write-only unidirectional data-binding (with `>` sign or `<=>`)
- Support `date_time_picker`/`date_picker`/`time_picker` `time` bidirectional data-binding (with `<=>` sign)
- Support `checkbox` `checked` bidirectional data-binding (with `<=>` sign)
- Support `combobox` and `editable_combobox` `selected` property bidirectional data-binding (with `<=>` sign)
- Support `radio_buttons` `selected` property bidirectional data-binding (with `<=>` sign)
- Support `radio_menu_item` `checked` bidirectional data-binding (with `<=>` sign)
- Support `check_menu_item` `checked` bidirectional data-binding (with `<=>` sign)
- Support `table` `cell_rows` bidirectional data-binding (with `<=>` sign)
- Improve examples/form_table.rb with bidirectional data-binding for `table` `cell_rows`
- Support ability to attach multiple listeners (e.g. multiple `on_changed {}` on `entry`)
- Document nested/indexed data-binding

## Soon

- Support passing x and y coordinates to `image` keyword (only when over 3 args are passed)

- Support passing `table` `image`/`image_text` `cell_rows` image data as file path directly (without using `image` keyword)
- Simplify examples/basic_table_image.rb to pass image data as file path directly
- Simplify examples/basic_table_image_text.rb to pass image data as file path directly
- Simplify examples/basic_table_color.rb to pass image data as file path directly

- Add Windows screenshots for examples/basic_scrolling_area.rb (and #scrolling-area section)
- Add Windows screenshot for examples/button_counter.rb
- Update Windows screenshot of examples/meta_example.rb
- Document area inclusion of explicit and implicit path shapes
- Demo examples/button_counter.rb at the top of the README

## Future

- Glimmerize examples/draw_text.rb from Ruby LibUI project
- Glimmerize examples/spectrum.rb from Ruby LibUI project
- Glimmerize examples/turing_pattern.rb from Ruby LibUI project

- Support `contain?` method in `arc` (todo), `polygon` (handled in `georuby` or `winding-polygon` or `point-in-polygon` or `is` or `polygon-validator` or `pip` gem), `polyline` (handled), `polybezier` (not handled), and `figure` (semi-handled unless beziers are in)
- Support `include?` method in `arc` (todo), `polygon` (handled in georuby), `polyline` (handled), `polybezier` (not handled), and `figure` (semi-handled unless beziers are in)
- Support `bounds` method in `polygon`, `polyline`, `polybezier`, and all other shapes

- Support Custom Shapes, describing composite shapes/text/image concepts inside an `area`
- Simpler Drag and Drop via `drag_source true`, `drag_and_move true`, `drop_target true`, and `on_drop { }` event
- examples/area_drag_and_move.rb (drag around drawn objects like a house, animals, and people)
- examples/area_drag_and_drop.rb (customize a face with face parts like mustache, nose, lips, eyes, and hair)
- Extract geometrical algorithms into their own gem `perfect_shape` (Complete Ruby Geometry Library Covering Math Operations for All Geometrical Shapes like Rectangle, Square, Arc, Circle, Polygon, Polyline, Polybezier, and Polyquad)

## Far Future

- Support custom keywords representing controls, shapes, matrices, message boxes or windows
- Automate OCRA support for Windows Native-Executable Packaging
- Implement Mac Native-Executable Packaging (perhaps with https://github.com/create-dmg/create-dmg or https://github.com/sveinbjornt/Platypus)
- Scaffold an application with support for gem and native-executable packaging
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
- examples/basic_toolbar.rb
- Support `max_content_size` and `min_content_size` properties for `window`
- Consider extracting a general graph custom control from `examples/histogram.rb`
- Support reopening `table` `content {}` by destroying and rebuilding (right now, it does nothing)
- Support returning a control view binding object with a deregister method to debind (currently not possible given libui does not support deregistering listeners)

# Refactoring

- Refactor column proxies code to be more dynamic and enable autosupport of new columns in the future
- Split attribute getter/setter methods that accept value as nil or empty with separate getter and setter methods and ensure calls to libui setters are routed to attr= methods
- Use enum symbols everwhere enum values are used directly
