# Copyright (c) 2021 Andy Maleh
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'glimmer/libui/control_proxy'

module Glimmer
  module LibUI
    # Proxy for LibUI table objects
    #
    # Follows the Proxy Design Pattern
    class TableProxy < ControlProxy
      attr_reader :model_handler, :model, :table_params, :columns
    
      def initialize(keyword, parent, args, &block)
        @keyword = keyword
        @parent_proxy = parent
        @args = args
        @block = block
        @enabled = true
        @columns = []
        @cell_rows = []
        window_proxy.on_destroy do
          # the following unless condition is an exceptional condition stumbled upon that fails freeing the table model
          ::LibUI.free_table_model(@model) unless @destroyed && parent_proxy.is_a?(Glimmer::LibUI::Box)
        end
      end
      
      def post_add_content
        build_control
        super
      end
      
      def post_initialize_child(child)
        @columns << child
        # add an extra complementary nil column if it is a dual column (i.e. ImageTextColumnProxy or CheckboxTextColumnProxy
        @columns << nil if child.is_a?(DualColumn)
      end
      
      def destroy
        super
        @destroyed = true
      end
      
      def cell_rows(rows = nil)
        if rows.nil?
          @cell_rows
        else
          rows = rows.map do |row|
            row.map do |cell|
              if cell.respond_to?(:libui)
                cell.libui
              elsif cell.is_a?(Array)
                cell.map { |inner_cell| inner_cell.respond_to?(:libui) ? inner_cell.libui : inner_cell }
              else
                cell
              end
            end
          end
          @cell_rows = rows
        end
      end
      alias cell_rows= cell_rows
      alias set_cell_rows cell_rows
      
      def expanded_cell_rows
        cell_rows.map do |row|
          row.flatten(1)
        end
      end
      
      def editable(value = nil)
        if value.nil?
          @editable
        else
          @editable = !!value
        end
      end
      alias editable= editable
      alias set_editable editable
      alias editable? editable
      
      private
      
      def build_control
        @model_handler = ::LibUI::FFI::TableModelHandler.malloc
        @model_handler.NumColumns   = rbcallback(4) { @columns.map {|c| c.is_a?(DualColumn) ? 2 : 1}.sum }
        @model_handler.ColumnType   = rbcallback(4, [1, 1, 4]) do |_, _, column|
          case @columns[column]
          when TextColumnProxy, ButtonColumnProxy, NilClass
            0
          when ImageColumnProxy, ImageTextColumnProxy
            1
#           when CheckboxColumnProxy
#             2
#           when CheckboxTextColumnProxy
#             2
#           when ProgressBarColumnProxy
#             2
          end
        end
        @model_handler.NumRows      = rbcallback(4) { cell_rows.count }
        @model_handler.CellValue    = rbcallback(1, [1, 1, 4, 4]) do |_, _, row, column|
          the_cell_rows = expanded_cell_rows
          case @columns[column]
          when TextColumnProxy, ButtonColumnProxy, NilClass
            ::LibUI.new_table_value_string((expanded_cell_rows[row] && expanded_cell_rows[row][column]).to_s)
          when ImageColumnProxy, ImageTextColumnProxy
            ::LibUI.new_table_value_image((expanded_cell_rows[row] && expanded_cell_rows[row][column]))
          end
        end
        @model_handler.SetCellValue = rbcallback(0, [1, 1, 4, 4, 1]) do |_, _, row, column, val|
          case @columns[column]
          when TextColumnProxy
            column = @columns[column].index
            @cell_rows[row] ||= []
            @cell_rows[row][column] = ::LibUI.table_value_string(val).to_s
          when NilClass
            column = @columns[column - 1].index
            @cell_rows[row][column][1] = ::LibUI.table_value_string(val).to_s
          when ButtonColumnProxy
            @columns[column].notify_listeners(:on_clicked, row)
          end
        end
        
        @model = ::LibUI.new_table_model(@model_handler)
        
        @table_params = ::LibUI::FFI::TableParams.malloc
        @table_params.Model = @model
        @table_params.RowBackgroundColorModelColumn = -1
        
        @libui = ControlProxy.new_control(@keyword, [@table_params])
        @libui.tap do
          @columns.each {|column| column&.send(:build_control) }
        end
      end
      
      def rbcallback(*args, &block)
        # TODO consider moving to a more general reusable location in the future (e.g. when used with `AreaProxy`)
        # Protects BlockCaller objects from garbage collection.
        @blockcaller ||= []
        args << [0] if args.size == 1 # Argument types are ommited
        blockcaller = Fiddle::Closure::BlockCaller.new(*args, &block)
        @blockcaller << blockcaller
        blockcaller
      end
      
      def next_column_index
        @next_column_index ||= -1
        @next_column_index += 1
      end
      
    end
  end
end
