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
require 'glimmer/libui/control_proxy/dual_column'
require 'glimmer/libui/control_proxy/triple_column'
require 'glimmer/data_binding/observer'
require 'glimmer/fiddle_consumer'

using ArrayIncludeMethods

module Glimmer
  module LibUI
    class ControlProxy
      # Proxy for LibUI table objects
      #
      # Follows the Proxy Design Pattern
      class TableProxy < ControlProxy
        include Glimmer::FiddleConsumer
        
        LISTENERS = ['on_changed', 'on_edited']
        
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
            ::LibUI.free_table_model(@model) unless @destroyed && parent_proxy.is_a?(Box)
          end
        end
        
        def post_add_content
          build_control unless @content_added
          super
        end
        
        def post_initialize_child(child)
          @columns << child
          # add extra complementary columns (:text, :color) if it is a dual/triple column (i.e. ImageTextColumnProxy or CheckboxTextColumnProxy
          case child
          when Column::ImageTextColumnProxy, Column::CheckboxTextColumnProxy
            @columns << :text
          when Column::TextColorColumnProxy
            @columns << :color
          when Column::CheckboxTextColorColumnProxy, Column::ImageTextColorColumnProxy
            @columns << :text
            @columns << :color
          end
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
            @cell_rows.tap do
              @last_cell_rows = array_deep_clone(@cell_rows)
              Glimmer::DataBinding::Observer.proc do |new_cell_rows|
                if @cell_rows.size < @last_cell_rows.size && @last_cell_rows.include_all?(*@cell_rows)
                  @last_cell_rows.array_diff_indexes(@cell_rows).reverse.each do |row|
                    ::LibUI.table_model_row_deleted(model, row)
                    on_changed.each {|listener| listener.call(row, :deleted, @last_cell_rows[row])}
                  end
                elsif @cell_rows.size > @last_cell_rows.size && @cell_rows.include_all?(*@last_cell_rows)
                  @cell_rows.array_diff_indexes(@last_cell_rows).each do |row|
                    ::LibUI.table_model_row_inserted(model, row)
                    on_changed.each {|listener| listener.call(row, :inserted, @cell_rows[row])}
                  end
                else
                  @cell_rows.each_with_index do |new_row_data, row|
                    if new_row_data != @last_cell_rows[row]
                      ::LibUI.table_model_row_changed(model, row)
                      on_changed.each {|listener| listener.call(row, :changed, @cell_rows[row])}
                    end
                  end
                end
                @last_last_cell_rows = array_deep_clone(@last_cell_rows)
                @last_cell_rows = array_deep_clone(@cell_rows)
              end.observe(self, :cell_rows, recursive: true)
            end
          end
        end
        alias cell_rows= cell_rows
        alias set_cell_rows cell_rows
        
        def expanded_cell_rows
          expand(cell_rows)
        end
        
        def expand(cell_rows)
          cell_rows.to_a.map do |row|
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
          @model_handler.NumColumns   = fiddle_closure_block_caller(4) { @columns.map {|c| c.is_a?(DualColumn) ? 2 : (c.is_a?(TripleColumn) ? 3 : 1)}.sum }
          @model_handler.ColumnType   = fiddle_closure_block_caller(4, [1, 1, 4]) do |_, _, column|
            # TODO consider refactoring to use Glimmer::LibUI.enum_symbols(:table_value_type)
            case @columns[column]
            when Column::TextColumnProxy, Column::ButtonColumnProxy, Column::TextColorColumnProxy, :text
              0
            when Column::ImageColumnProxy, Column::ImageTextColumnProxy, Column::ImageTextColorColumnProxy
              1
            when Column::CheckboxColumnProxy, Column::CheckboxTextColumnProxy, Column::CheckboxTextColorColumnProxy, Column::ProgressBarColumnProxy
              2
            when Column::BackgroundColorColumnProxy, :color
              3
            end
          end
          @model_handler.NumRows      = fiddle_closure_block_caller(4) do
            # Note: there is a double-delete bug in Windows when performing table_model_row_deleted, which requires pre-adding and extra empty row
            cell_rows.count + (OS.windows? ? 1 : 0)
          end
          @model_handler.CellValue    = fiddle_closure_block_caller(1, [1, 1, 4, 4]) do |_, _, row, column|
            the_cell_rows = expanded_cell_rows
            case @columns[column]
            when Column::TextColumnProxy, Column::ButtonColumnProxy, Column::TextColorColumnProxy, :text
              ::LibUI.new_table_value_string((expanded_cell_rows[row] && expanded_cell_rows[row][column]).to_s)
            when Column::ImageColumnProxy, Column::ImageTextColumnProxy, Column::ImageTextColorColumnProxy
              if OS.windows? && row == cell_rows.count
                ::LibUI.new_table_value_image((expanded_cell_rows[row - 1] && (expanded_cell_rows[row - 1][column].respond_to?(:libui) ? expanded_cell_rows[row - 1][column].libui : expanded_cell_rows[row - 1][column])))
              else
                ::LibUI.new_table_value_image((expanded_cell_rows[row] && (expanded_cell_rows[row][column].respond_to?(:libui) ? expanded_cell_rows[row][column].libui : expanded_cell_rows[row][column])))
              end
            when Column::CheckboxColumnProxy, Column::CheckboxTextColumnProxy, Column::CheckboxTextColorColumnProxy
              ::LibUI.new_table_value_int(((expanded_cell_rows[row] && (expanded_cell_rows[row][column] == 1 || expanded_cell_rows[row][column].to_s.strip.downcase == 'true' ? 1 : 0))) || 0)
            when Column::ProgressBarColumnProxy
              value = (expanded_cell_rows[row] && expanded_cell_rows[row][column]).to_i
              expanded_last_last_cell_rows = expand(@last_last_cell_rows)
              old_value = (expanded_last_last_cell_rows[row] && expanded_last_last_cell_rows[row][column]).to_i
              if OS.windows? && old_value == -1 && value >= 0
                Glimmer::Config.logger.error('Switching a progress bar value from -1 to a positive value is not supported on Windows')
                cell_rows[row][column] = -1
                ::LibUI.new_table_value_int(old_value)
              else
                ::LibUI.new_table_value_int((expanded_cell_rows[row] && expanded_cell_rows[row][column]).to_i)
              end
            when Column::BackgroundColorColumnProxy
              background_color = Glimmer::LibUI.interpret_color(expanded_cell_rows[row] && expanded_cell_rows[row][column]) || {r: 255, g: 255, b: 255}
              ::LibUI.new_table_value_color(background_color[:r] / 255.0, background_color[:g] / 255.0, background_color[:b] / 255.0, background_color[:a] || 1.0)
            when :color
              color = Glimmer::LibUI.interpret_color(expanded_cell_rows[row] && expanded_cell_rows[row][column]) || {r: 0, g: 0, b: 0}
              ::LibUI.new_table_value_color(color[:r] / 255.0, color[:g] / 255.0, color[:b] / 255.0, color[:a] || 1.0)
            end
          end
          @model_handler.SetCellValue = fiddle_closure_block_caller(0, [1, 1, 4, 4, 1]) do |_, _, row, column, val|
            case @columns[column]
            when Column::TextColumnProxy
              column = @columns[column].index
              @cell_rows[row] ||= []
              @cell_rows[row][column] = ::LibUI.table_value_string(val).to_s
            when Column::TextColorColumnProxy
              column = @columns[column].index
              @cell_rows[row] ||= []
              @cell_rows[row][column] ||= []
              @cell_rows[row][column][0] = ::LibUI.table_value_string(val).to_s
            when :text
              column = @columns[column - 1].index
              @cell_rows[row] ||= []
              @cell_rows[row][column] ||= []
              @cell_rows[row][column][1] = ::LibUI.table_value_string(val).to_s
            when Column::ButtonColumnProxy
              @columns[column].notify_listeners(:on_clicked, row)
            when Column::CheckboxColumnProxy
              column = @columns[column].index
              @cell_rows[row] ||= []
              @cell_rows[row][column] = ::LibUI.table_value_int(val).to_i == 1
            when Column::CheckboxTextColumnProxy
              column = @columns[column].index
              @cell_rows[row] ||= []
              @cell_rows[row][column] ||= []
              @cell_rows[row][column][0] = ::LibUI.table_value_int(val).to_i == 1
            end
            on_edited.each {|listener| listener.call(row, @cell_rows[row])}
          end
          
          @model = ::LibUI.new_table_model(@model_handler)
          
          # figure out and reserve column indices for columns
          @columns.each { |column| column.respond_to?(:column_index) && column.column_index }
          
          @table_params = ::LibUI::FFI::TableParams.malloc
          @table_params.Model = @model
          @table_params.RowBackgroundColorModelColumn = @columns.find {|column| column.is_a?(Column::BackgroundColorColumnProxy)}&.column_index || -1
          
          @libui = ControlProxy.new_control(@keyword, [@table_params])
          @libui.tap do
            @columns.each {|column| column.respond_to?(:build_control, true) && column.send(:build_control) }
          end
        end
        
        def next_column_index
          @next_column_index ||= -1
          @next_column_index += 1
        end
        
        def array_deep_clone(array_or_object)
          if array_or_object.is_a?(Array)
            array_or_object.map do |element|
              array_deep_clone(element)
            end
          else
            array_or_object.clone
          end
        end
      end
    end
  end
end
