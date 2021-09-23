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
      end
      
      def destroy
        super
        @destroyed = true
      end
      
      def cell_rows(rows = nil)
        if rows.nil?
          @cell_rows
        else
          @cell_rows = rows
        end
      end
      alias cell_rows= cell_rows
      alias set_cell_rows cell_rows
      
      private
      
      def build_control
        @model_handler = ::LibUI::FFI::TableModelHandler.malloc
        @model_handler.NumColumns   = rbcallback(4) { @columns.count }
        @model_handler.ColumnType   = rbcallback(4) { 0 } # TODO derive from @columns when supporting multiple column types in the future
        @model_handler.NumRows      = rbcallback(4) { cell_rows.count }
        @model_handler.CellValue    = rbcallback(1, [1, 1, 4, 4]) do |_, _, row, column|
          ::LibUI.new_table_value_string((@cell_rows[row] && @cell_rows[row][column]).to_s)
        end
        
        @model = ::LibUI.new_table_model(@model_handler)
        
        @table_params = ::LibUI::FFI::TableParams.malloc
        @table_params.Model = @model
        @table_params.RowBackgroundColorModelColumn = -1
        
        @libui = ControlProxy.new_control(@keyword, [@table_params])
        @libui.tap do
          @columns.each {|column| column.send(:build_control) }
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
      
    end
  end
end
