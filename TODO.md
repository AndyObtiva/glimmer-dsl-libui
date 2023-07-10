# TODO

## Next

- Ensure that shape/path containment/inclusion checks take their transform into account while using `PerfectShape`
- Ensure support for nesting a composite `shape` within another composite `shape`

- Look into providing absolute values (incorporating relative position to parent composite shape) for PerfectShaped bounding box elements

- Support `LibUI.uninit` to enable clean exit of a LibUI app in Linux and support launching/closing a LibUI app window multiple times

- Rename basic table selection example to something that indicates sorting too
- Fix issue with button_column on_clicked not resulting in click of button yet click of column. It seems we have to add a on_button_clicked alternative here. and break the API
- Provide a way to configure a different sort_by or sort block per table column while relying on sortable property

- Support a `window.quit` operation that is a shortcut for `window.destroy` followed by `::LibUI.quit`
- Enable usage of `msg_box` and `msg_box_error` without constructing a `window` explicitly or launching a `Glimmer::LibUI::Application` to enable quick command line triggering of message boxes if needed.
- Automate table sorting support (perhaps via a property, sortable, which should default to true). Must handle cell_rows as array of arrays, array of hashes, and array of models. Does not work if cell_rows is an lazy enumerable

- Option for in-memory only sort for table in case we don't want to store the sort back on the model
- Table sorting for refined_table

- Control content data-binding to generate nested controls dynamically based on a model attribute change
- Enable usage of `msg_box` and `msg_box_error` without constructing a `window` explicitly or launching a `Glimmer::LibUI::Application` to enable quick command line triggering of message boxes if needed.

- Automate the use of Glimmer::LibUI.queue_main from other threads

- Figure out if there is a way to make `on_mouse_up` listener work when nested inside immediate mode shapes created inside `area` `on_draw`
- Update Supported Controls documentation with allowed parents and allowed children
- Support overriding global `table` `editable` state with a specific column `editable` state if global value is `true` and column value is `false`

- Make `table` columns default to empty string if no text is provided for the name of the column
- Support table `cell_rows` live-loading via a provider (e.g. `cell_rows { |row, cell| value_based_on_row_and_cell }` ) (refactor apps that need it to use it)
- Support table `cell_rows` live-loading via a provider with caching (e.g. `cell_rows(cache: true) { |row, cell| value_based_on_row_and_cell }` )

- Support table `cell_rows` provider as an alternative to data-binding (by passing a block that takes row, column arguments)
- Make `table` columns default to empty string if no text is provided for the name of the column

- Use polyline in one more place in histogram
- Provide a guide comparing use of path with path having figure with shape shorcuts (e.g. polyline, which abstracts path and figure away)

- It seems that table-related instability in Windows is back. Check what is causing it. Test with RefinedTable
- Fix issue with version 4 of Area Gallery

- examples/area_tooltip.rb & examples/area_tooltip_with_delay.rb
- examples/linked_pages.rb (build a link-based desktop example that works similarly to web pages with hyperlinks)

### 0.5.x

- Support Custom Shapes, describing composite shapes/text/image concepts inside an `area`
- Support Custom Shape `bounding_box` (minx, miny, width, height), `contain?` method (checking if shape contains point inside) and `include?` method (checking on outline if stroked and inside if filled?)
- Look into extracting `bevel` Custom Shape in Tetris

### 0.5.x

- class based custom shape example (randomly generated custom shape coloring). Build Hangman the game.

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

- Scaffold an application
- Zenity-like Command-Line-Mode-GUI Scaffolding
- Full MVC + Database scaffolding
- Look into whether keyboard listeners must not be allowed within shapes since they do not carry an x/y element like mouse listeners
- Report to libui the delay issue in calling on changed listener on `search_entry` (not a problem with basic `entry`)
- Update shape_coloring.rb to use data-binding (must support being able to set top-left x,y on any shape instead of relying on move_by to make it work with data-binding, just like Glimmer DSL for SWT supports that)
- Add padding around code_area (empty space to the left and right and empty line on top and at the bottom)
- Refactor all samples that use a class including Glimmer to utilize CustomWindow instead
- examples/file_tabs.rb (inspired by this addressed issue: https://github.com/AndyObtiva/glimmer-dsl-libui/issues/16)
- Glimmerize examples/draw_text.rb from Ruby LibUI project
- Glimmerize examples/spectrum.rb from Ruby LibUI project
- Glimmerize examples/turing_pattern.rb from Ruby LibUI project
- Game of Life

## Future

- Add an example demonstrating how to use a SQLite database through ActiveRecord in Glimmer DSL for LibUI
- Support `refined_table` sorting
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
- Integrate GR chart/plot support into Glimmer DSL for LibUI (or provide a custom control gem for it) once LibUI supports image rendering or pixel drawing in an efficient manner
- `paginated_filtered_table` widget or something similar (like splitting `pagination` and `filter` as separate widgets)
- Optimize table content changes with diffing
- Support `refined_table` AND-based FTS (Full-Text-Search) queries by treating multiple words as WORD1 AND WORD2, and accepting syntax of WORD1 AND WORD2 as alternative (or 'and' or '&', or '&&')
- Support `refined_table` OR-based FTS (Full-Text-Search) queries by accepting syntax of WORD1 OR WORD2, etc..., (or 'or' or '|' or '||')
- Build a MiniTest/RSpec test runner that shows results in a GUI app
- Show progress-bar while loading a completion in GPT2 Notepad
- Have `table` tolerate adding `nil` in implicit data-binding by treating it as an empty row
- As a performance optimization, have `table` change expanded_cell_rows only for updated cells instead of regenerating from scratch upon every cell/row change.
- Support `refined_table` `cell_rows` lazy loading via Enumerator
- consider replacing chunky png gem with exif to additionally support jpeg and tiff with higher native extension performance: https://github.com/tonytonyjan/exif or https://github.com/wilg/mini_exiftool_vendored
- Validate control's allowed parents and allowed children to help with using the GUI DSL when making mistakes
- Figure out if there is a way to dynamically support listeners/properties from FFI functions without having to hardcode them (like the new addition of table.on_selection_changed)
- Consider doing special sorting for table progress_bar column where -1 shows up bigger than 100%
- Consider preserving selection for `refined_table` across pages so that if I select a row in page 1 and go to page 2, selection is removed, and then when I go back to page 1, selection is back at the correct row

# Refactoring

- Refactor column proxies code to be more dynamic and enable autosupport of new columns in the future
- Split attribute getter/setter methods that accept value as nil or empty with separate getter and setter methods and ensure calls to libui setters are routed to attr= methods
- Use enum symbols everwhere enum values are used directly
- Refactor all perfect_shape methods to do parameterized memoization automatically with some declarative method or some library
