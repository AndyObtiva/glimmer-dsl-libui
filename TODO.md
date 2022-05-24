# TODO

- Look into whether keyboard listeners must not be allowed within shapes since they do not carry an x/y element like mouse listeners

## Next 0.5.12

- Modify default window closing behavior to autodetect if the window is not the last open window, and in which case, ensure that closing the window does not close the app.
- Update shape_coloring.rb to use data-binding
- Accept `true` and `false` as return values for `on_closing` window listener as aliases to `1` and `0`

### 0.5.x

- Support `shape` keyword as aggregate (composite) shape that can have arbitrary shapes, text, transforms underneath

### 0.5.x

- Support Custom Shapes, describing composite shapes/text/image concepts inside an `area`
- Support Custom Shape `bounding_box` (minx, miny, width, height), `contain?` method (checking if shape contains point inside) and `include?` method (checking on outline if stroked and inside if filled?)
- Look into extracting `bevel` Custom Shape in Tetris

### 0.5.x

- class based custom shape example (randomly generated custom shape coloring)

### 0.5.x

- Support `drag_and_move true` (just enables dragging and moving shapes in area)

### 0.5.x

- examples/area_drag_and_move.rb (customize a face with face parts like mustache, nose, lips, eyes, eyebrows, and hair) [utilize SVGs from https://editor.dicebear.com/]

### 0.5.x

- Simpler Drag and Drop via `drag_source true`, `drop_target true`, and `on_drop { }` event (working within same area)

### 0.5.x

- Build Quarto game sample using area drag and drop: https://en.gigamic.com/game/quarto-classic

### 0.5.x

- Augment examples/class_based_custom_controls.rb example with a custom listener

## Soon

- Refactor all samples that use a class including Glimmer to utilize CustomWindow instead
- examples/file_tabs.rb (inspired by this addressed issue: https://github.com/AndyObtiva/glimmer-dsl-libui/issues/16)
- Glimmerize examples/draw_text.rb from Ruby LibUI project
- Glimmerize examples/spectrum.rb from Ruby LibUI project
- Glimmerize examples/turing_pattern.rb from Ruby LibUI project
- Game of Life

## Future

- Support `code_editor` class-based custom control as a code-syntax-highlighted `entry` control using the `rouge` gem
- Build app for sportdb gem
- Build app for beerdb gem
- Support class-based custom matrix transform
- Area-based class-based custom control keyword: iPhone-like toggle button with these properties:
```ruby
    self.toggle_button_width = 72
    self.toggle_button_height = 36
    self.toggle_button_on_fill = {r: 54, g: 202, b: 110}
    self.toggle_button_off_fill = {r: 214, g: 214, b: 214}
    self.toggle_button_switch_fill = {r: 247, g: 247, b: 247}
```

## Far Future

- Scaffold an application
- Optimize startup time, perhaps dropping 'os' gem for direct use of `Gem::Platform.local` instead.
- Support configuration of global widget default properties to quickly affect the style of an entire app globally without the complexity of CSS expressions.
- Automate OCRA support for Windows Native-Executable Packaging
- Implement Mac Native-Executable Packaging (perhaps with https://github.com/create-dmg/create-dmg or https://github.com/sveinbjornt/Platypus)
- Cover all of Glimmer DSL for LibUI with automated tests and a continuous integration server on Mac, Windows, and Linux to release version 1.0.0

## Maybe

- Support Dynamic `path` `save` and `restore` calls
- Support nested paths/shapes in Path DSL with relative positioning
- Trap exit signal (CTRL+C) and close application gracefully (it seems using ractors or sleep causes CTRL+C to work, could be a good workaround)
- Support optionally passing arguments to columns for LibUI.append_column_xyz methods
- Support `table` `on_changing` listener to intercept change and cancel it if needed (`on_changing`)
- Fold menus inside a `menu_bar` control
- Support `matrix` `transform_point` method
- Support `point` construct (as a `rectangle` with width/height of `1`)
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
- Try to provide more helpful error messages on user error when it results in segementation fault (like setting nil as `entry` `text`) or prevent such cases altogether with smart defaults
- Demonstrate use of table with database data (e.g. sqlite)
- Support x, y, diameter alternative dimensions for circle
- Support `rgb` and `rgba` keywords for easier entry of colors, similar to that of Glimmer DSL for SWT
- Invert or expand the use of Glimmer::LibUI::ControlProxy::KEYWORD_ALIASES with an array (it does not permit definining multiple aliases at the moment)
- Drag and drop working across different areas
- Offer fuzz comparison options for Shape#include?(*point) on outline when stroked or in general (available in PerfectShape)
- Scaffold a custom control gem
- Scaffold a custom shape gem
- Scaffold a custom control within existing application
- Scaffold a custom shape within existing application
- Support Linux AARCH64
- Support `#glimmer` method (alias `#control_proxy`) on libui objects (obtained through `#libui` method on controls) to obtain Glimmer control proxy
- Support `#custom_control` method on libui objects that are the root of a class-based custom control (consider adding to control proxies too that are roots of custom controls)
- Support textual tooltips (on hover over attributed strings) in `code_area` custom control (and potentially `code_editor` custom control)
- Look into the potential issue with not respecting the even odd rule when triggering events on figures within a path

# Refactoring

- Refactor column proxies code to be more dynamic and enable autosupport of new columns in the future
- Split attribute getter/setter methods that accept value as nil or empty with separate getter and setter methods and ensure calls to libui setters are routed to attr= methods
- Use enum symbols everwhere enum values are used directly
- Refactor all perfect_shape methods to do parameterized memoization automatically with some declarative method or some library
