require 'glimmer-dsl-libui'

include Glimmer

data = [
  %w[cat meow],
  %w[dog woof],
  %w[chicken cock-a-doodle-doo],
  %w[horse neigh],
  %w[cow moo]
]

window('Animal sounds', 300, 200) {
  horizontal_box {
    table {
      text_column('Animal') {
#       table_header_on_clicked do |t|
#         puts 'table_header_on_clicked'
#         p t
#       end
      }
      text_column('Description')

      cell_rows data
      selection_mode :zero_or_many # other values are :none , :zero_or_one , and :one

      on_row_clicked do |t, row|
        puts "Row Clicked: #{row}"
      end

      on_row_double_clicked do |t, row|
        puts "Row Double Clicked: #{row}"
      end

      on_selection_changed do |t|
        # selection is an array or nil if selection mode is zero_or_many
        # otherwise, selection is a single index integer or nil when not selected
        puts "Selection Changed: #{t.selection.inspect}"
      end
    }
  }
}.show


# require 'libui'
#
# UI = LibUI
#
# UI.init
#
# main_window = UI.new_window('Animal sounds', 300, 200, 1)
#
# hbox = UI.new_horizontal_box
# UI.window_set_child(main_window, hbox)
#
# data = [
#   %w[cat meow],
#   %w[dog woof],
#   %w[chicken cock-a-doodle-doo],
#   %w[horse neigh],
#   %w[cow moo]
# ]
#
#### Protects BlockCaller objects from garbage collection.
# @block_callers = []
# def rbcallback(*args, &block)
#   args << [0] if args.size == 1 # Argument types are ommited
#   block_caller = Fiddle::Closure::BlockCaller.new(*args, &block)
#   @block_callers << block_caller
#   block_caller
# end
#
# model_handler = UI::FFI::TableModelHandler.malloc
# model_handler.to_ptr.free = Fiddle::RUBY_FREE
# model_handler.NumColumns   = rbcallback(4) { 2 }
# model_handler.ColumnType   = rbcallback(4) { 0 }
# model_handler.NumRows      = rbcallback(4) { 5 }
# model_handler.CellValue    = rbcallback(1, [1, 1, 4, 4]) do |_, _, row, column|
#   UI.new_table_value_string(data[row][column])
# end
# model_handler.SetCellValue = rbcallback(0, [0]) {}
#
# model = UI.new_table_model(model_handler)
#
# table_params = UI::FFI::TableParams.malloc
# table_params.to_ptr.free = Fiddle::RUBY_FREE
# table_params.Model = model
# table_params.RowBackgroundColorModelColumn = -1
#
# table = UI.new_table(table_params)
# UI.table_append_text_column(table, 'Animal', 0, -1)
# UI.table_append_text_column(table, 'Description', 1, -1)
# UI.table_set_selection_mode(table, UI::TableSelectionModeZeroOrMany)
#
# UI.table_on_row_clicked(table) do |_, row_idx|
#   puts "#{data[row_idx][0]} \"#{data[row_idx][1]}\""
# end
#
# UI.table_on_row_double_clicked(table) do |_, row_idx|
#   puts "#{data[row_idx][0]} \"#{data[row_idx][1]}!!\"".upcase
# end
#
#
# UI.table_on_selection_changed(table) do |ptr|
#   tsp = UI.table_get_selection(ptr)
#   ts = UI::FFI::TableSelection.new(tsp)
#   if ts.NumRows > 0 #
#     p selected: ts.Rows[0, Fiddle::SIZEOF_INT * ts.NumRows].unpack("i*")
#   end
#   UI.free_table_selection(tsp)
# end
#
# UI.table_header_on_clicked(table) do |_, col_idx|
#   puts col_idx
# end
#
#
# UI.box_append(hbox, table, 1)
# UI.control_show(main_window)
#
# UI.window_on_closing(main_window) do
#   puts 'Bye Bye'
#   UI.control_destroy(main_window)
#   UI.free_table_model(model)
#   UI.quit
#   0
# end
#
# UI.main
# UI.quit
