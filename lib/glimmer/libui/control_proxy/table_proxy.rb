# Copyright (c) 2021-2024 Andy Maleh
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
        
        CUSTOM_LISTENER_NAMES = ['on_changed', 'on_edited']
        DEFAULT_COLUMN_SORT_BLOCK = lambda do |table_cell_row, column, table_proxy|
          if table_cell_row.is_a?(Array)
            value = table_cell_row[column]
          else
            attribute = table_proxy.column_attributes[column]
            value = table_cell_row.send(attribute)
          end
          if value.is_a?(Array)
            # This is needed to not crash on sorting an unsortable array
            value = value.map do |element|
              case element
              when true
                1
              when false
                0
              else
                element
              end
            end
          end
          value
        end
        
        attr_reader :model_handler, :model, :table_params, :columns
      
        def initialize(keyword, parent, args, &block)
          @keyword = keyword
          @parent_proxy = parent
          @args = args
          @block = block
          @enabled = true
          @columns = []
          @cell_rows = []
          @last_cell_rows = nil
          register_cell_rows_observer
          window_proxy.on_destroy do
            # the following unless condition is an exceptional condition stumbled upon that fails freeing the table model
            ::LibUI.free_table_model(@model) unless @destroyed && parent_proxy.is_a?(Box)
          end
        end
        
        def post_add_content
          build_control if !@content_added && @libui.nil?
          super
          # TODO consider automatically detecting what properties/listeners accumulated dynamically to avoid hardcoding code below
          register_listeners
          register_column_listeners
          configure_selection_mode
          configure_selection
          configure_header_visible
          configure_column_sort_indicators
          configure_sorting
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
          # TODO consider replacing unobserve with observer_registration.deregister
          @cell_rows_observer&.unobserve(self, :cell_rows, recursive: true, ignore_frozen: true, attribute_writer_type: [:attribute=, :set_attribute])
          @destroyed = true
        end
        
        def cell_rows(rows = nil)
          if rows.nil?
            @cell_rows
          else
            if !rows.equal?(@cell_rows)
              @cell_rows = rows
              # TODO instead of clearing cached cell rows, consider amending cached cell rows for better performance (to avoid regenerating them)
              clear_cached_cell_rows
              if @cell_rows.is_a?(Enumerator)
                @cell_rows.rewind
                @future_last_cell_rows = array_deep_dup(@cell_rows) # must be done after rewinding
              end
            end
            @cell_rows
          end
        end
        alias cell_rows= cell_rows
        alias set_cell_rows cell_rows
        
        def expand_cell_rows(cell_rows = nil)
          cell_rows ||= self.cell_rows
          cell_rows ||= []
          cell_rows.map { |cell_row| expand_cell_row(cell_row) }
        end
        alias expanded_cell_rows expand_cell_rows
        
        def expand_cell_row(cell_row)
          return cell_row if cell_row.nil?
          cell_row = expand_cell_row_from_model(cell_row) if !cell_row.is_a?(Array) && column_attributes.any?
          cell_row.flatten(1)
        end
        
        def expand_cell_row_from_model(cell_row)
          column_attributes.to_a.map {|attribute| cell_row.send(attribute) }
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
        
        def selection_mode(value = nil)
          if value.nil?
            @selection_mode
          else
            value = LibUI.enum_symbol_to_value(:table_selection_mode, value)
            @selection_mode = value
          end
        end
        alias selection_mode= selection_mode
        alias set_selection_mode selection_mode
        
        def selection
          return @selection if !@content_added
          
          tsp = super
          ts = ::LibUI::FFI::TableSelection.new(tsp)
          if ts.NumRows > 0
            selection_array = ts.Rows[0, Fiddle::SIZEOF_INT * ts.NumRows].unpack("i*")
            selection_mode == ::LibUI::TableSelectionModeZeroOrMany ? selection_array : selection_array.first
          end
        ensure
          ::LibUI.free_table_selection(tsp)
        end
        
        def selection=(*value)
          value = value.first if value.size == 1
          @selection = value
          return @selection if !@content_added
          return if @selection.nil?
        
          ts = ::LibUI::FFI::TableSelection.malloc
          ts.NumRows = @selection.is_a?(Array) ? @selection.size : 1
          ts.Rows = [@selection].flatten.pack('i*')
          super(ts)
          # TODO figure out why ensure block is not working (perhaps libui auto-frees that resource upon setting selection)
          # Delete following code if not needed.
#         ensure
#           ::LibUI.free_table_selection(ts)
        end
        alias set_selection selection=
        
        def header_visible
          return @header_visible if !@content_added
          
          result = ::LibUI.table_header_visible(@libui)
          LibUI.integer_to_boolean(result)
        end
        alias header_visible? header_visible
        
        def header_visible=(value)
          @header_visible = value
          return @header_visible if !@content_added
          return if value.nil?
          
          value = LibUI.boolean_to_integer(value)
          ::LibUI.table_header_set_visible(@libui, value)
        end
        alias set_header_visible header_visible=
        
        def sortable
          @sortable = true if @sortable.nil?
          @sortable
        end
        alias sortable? sortable
        
        def sortable=(value)
          @sortable = value
        end
        alias set_sortable sortable=
        
        def column_attributes
          @column_attributes ||= columns.select {|column| column.is_a?(Column)}.map(&:name).map(&:underscore)
        end
        
        def data_bind_read(property, model_binding)
          if model_binding.binding_options[:column_attributes].is_a?(Array)
            @column_attributes = model_binding.binding_options[:column_attributes]
          else
            column_attribute_mapping = model_binding.binding_options[:column_attributes].is_a?(Hash) ? model_binding.binding_options[:column_attributes] : {}
            @column_attributes = columns.select {|column| column.is_a?(Column)}.map(&:name).map {|column_name| column_attribute_mapping[column_name] || column_name.underscore}
          end
          model_attribute_observer = model_attribute_observer_registration = nil
          model_attribute_observer = Glimmer::DataBinding::Observer.proc do
            new_value = model_binding.evaluate_property
            if !new_value.is_a?(Enumerator) &&
              (
                model_binding.binding_options[:column_attributes] ||
                (!new_value.nil? && (!new_value.is_a?(String) || !new_value.empty?) && (!new_value.is_a?(Array) || !new_value.first.is_a?(Array)))
              )
              @model_attribute_array_observer_registration&.deregister
              @model_attribute_array_observer_registration = model_attribute_observer.observe(new_value, column_attributes, ignore_frozen: true, attribute_writer_type: [:attribute=, :set_attribute])
              model_attribute_observer.add_dependent(model_attribute_observer_registration => @model_attribute_array_observer_registration)
            end
            # TODO look if multiple notifications are happening as a result of observing array and observing model binding
            last_cell_rows = @last_cell_rows || [] # initialize with empty array of first time loading table (only time when @last_cell_rows is nil)
            send("#{property}=", new_value) unless last_cell_rows == new_value
          end
          model_attribute_observer_registration = model_attribute_observer.observe(model_binding, attribute_writer_type: [:attribute=, :set_attribute])
          model_attribute_observer.call # initial update
          data_binding_model_attribute_observer_registrations << model_attribute_observer_registration
          model_attribute_observer
        end
        
        def data_bind_write(property, model_binding)
          case property
          when 'cell_rows'
            handle_listener('on_edited') { model_binding.call(cell_rows) }
          when 'selection'
            handle_listener('on_selection_changed') { model_binding.call(selection) }
          end
        end
        
        def array_deep_dup(array_or_object)
          if array_or_object.is_a?(Array)
            array_or_object.map do |element|
              array_deep_dup(element)
            end
          else
            array_or_object.dup
          end
        end
        
        def compound_column_index_for(expanded_column_index)
          compound_column = @columns.find { |compound_column| compound_column.respond_to?(:column_index) && compound_column.column_index == expanded_column_index }
          compound_columns = @columns.select { |compound_column| compound_column.is_a?(Column) }
          compound_columns.index(compound_column)
        end
        
        def column_proxies
          @columns&.select {|c| c.is_a?(Column)}
        end
        
        def handle_listener(listener_name, &listener)
          # if content has been added, then you can register listeners immediately (without accumulation)
          if CUSTOM_LISTENER_NAMES.include?(listener_name) || @content_added
            actual_listener = listener
            case listener_name
            when 'on_selection_changed'
              actual_listener = Proc.new do |myself, *args|
                added_selection = selection.is_a?(Array) ? (selection - @old_selection.to_a) : selection
                removed_selection = selection.is_a?(Array) ? (@old_selection.to_a - selection) : @old_selection
                listener.call(myself, selection, added_selection, removed_selection)
              end
            end
            super(listener_name, &actual_listener)
          else
            # if content is not added yet, then accumulate listeners to register later when table content is closed
            @table_listeners ||= []
            @table_listeners << [listener_name, listener]
          end
        end
        
        private
        
        # returns table cell for row and column (expanded)
        def expanded_cell_for(row, column)
          cell_row = expanded_cell_row_for(row)
          cell = cell_row && cell_row[column]
        end
        
        def expanded_cell_row_for(row)
          expand_cell_row(cell_row_for(row))
        end
        
        def cell_row_for(row)
          @cached_cell_rows ||= []
          if @cached_cell_rows[row].nil?
            cell_rows = self.cell_rows || []
            if cell_rows.is_a?(Enumerator)
              @cached_cell_rows_size ||= @cached_cell_rows.size
              @cached_cell_rows_enumerator_index ||= 0
              # TODO consider handling size being nil and needing to force Enumerator count instead
              while @cached_cell_rows_enumerator_index <= row
                begin
                  @cached_cell_rows << cell_rows.next
                  @cached_cell_rows_enumerator_index += 1
                rescue StopIteration => e
                  break
                end
              end
            else
              @cached_cell_rows = cell_rows
            end
          end
          @cached_cell_rows[row]
        end
        
        def last_cell_row_for(row)
          # TODO refactor to share code with cell_row_for
          @cached_last_cell_rows ||= []
          if @cached_last_cell_rows[row].nil?
            last_cell_rows = @last_cell_rows || []
            if last_cell_rows.is_a?(Enumerator)
              @cached_last_cell_rows_size ||= @cached_last_cell_rows.size
              @cached_last_cell_rows_enumerator_index ||= 0
              # TODO consider handling size being nil and needing to force Enumerator count instead
              while @cached_last_cell_rows_enumerator_index <= row
                begin
                  @cached_last_cell_rows << last_cell_rows.next
                  @cached_last_cell_rows_enumerator_index += 1
                rescue StopIteration => e
                  break
                end
              end
            else
              @cached_last_cell_rows = last_cell_rows
            end
          end
          @cached_last_cell_rows[row]
        end
        
        def last_last_cell_row_for(row)
          # TODO refactor to share code with cell_row_for
          @cached_last_last_cell_rows ||= []
          if @cached_last_last_cell_rows[row].nil?
            last_last_cell_rows = @last_last_cell_rows || []
            if last_last_cell_rows.is_a?(Enumerator)
              @cached_last_last_cell_rows_size ||= @cached_last_last_cell_rows.size
              @cached_last_last_cell_rows_enumerator_index ||= 0
              # TODO consider handling size being nil and needing to force Enumerator count instead
              while @cached_last_last_cell_rows_enumerator_index <= row
                begin
                  @cached_last_last_cell_rows << last_last_cell_rows.next
                  @cached_last_last_cell_rows_enumerator_index += 1
                rescue StopIteration => e
                  break
                end
              end
            else
              @cached_last_last_cell_rows = last_last_cell_rows
            end
          end
          @cached_last_last_cell_rows[row]
        end
        
        def dup_last_cell_rows
          return (@last_cell_rows = nil) if @cell_rows.nil?
          # using future last cell rows guarantees that Enumerator is rewound
          @last_cell_rows = @future_last_cell_rows || array_deep_dup(@cell_rows)
          @future_last_last_cell_rows = array_deep_dup(@last_cell_rows)
          @future_last_cell_rows = nil
          clear_cached_last_cell_rows
          @last_cell_rows
        end
        
        def dup_last_last_cell_rows
          return (@last_last_cell_rows = nil) if @last_cell_rows.nil?
          # using future last cell rows guarantees that Enumerator is rewound
          @last_last_cell_rows = @future_last_last_cell_rows || array_deep_dup(@last_cell_rows)
          @future_last_last_cell_rows = nil
          clear_cached_last_last_cell_rows
          @last_last_cell_rows
        end
        
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
            cell_rows.size + (OS.windows? ? 1 : 0)
            # TODO consider handling case of Enumerator not having size, but having count that needs to be forced instead
          end
          @model_handler.CellValue    = fiddle_closure_block_caller(1, [1, 1, 4, 4]) do |_, _, row, column|
            cell_rows = self.cell_rows || []
            the_cell = expanded_cell_for(row, column)
            case @columns[column]
            when Column::TextColumnProxy, Column::ButtonColumnProxy, Column::TextColorColumnProxy, :text
              ::LibUI.new_table_value_string((the_cell).to_s)
            when Column::ImageColumnProxy, Column::ImageTextColumnProxy, Column::ImageTextColorColumnProxy
              if OS.windows? && row == cell_rows.size
                img = Glimmer::LibUI::ICON
              else
                img = the_cell
              end
              img = ControlProxy::ImageProxy.create('image', nil, img) if img.is_a?(Array)
              img = ControlProxy::ImageProxy.create('image', nil, [img]) if img.is_a?(String)
              img = img.respond_to?(:libui) ? img.libui : img
              ::LibUI.new_table_value_image(img)
            when Column::CheckboxColumnProxy, Column::CheckboxTextColumnProxy, Column::CheckboxTextColorColumnProxy
              ::LibUI.new_table_value_int(((the_cell == 1 || the_cell.to_s.strip.downcase == 'true' ? 1 : 0)) || 0)
            when Column::ProgressBarColumnProxy
              value = (the_cell).to_i
              expanded_last_last_cell_row = expand_cell_row(last_last_cell_row_for(row))
              # TODO consider only caching old value when displayed in CellValue before, but otherwise not worrying about it (if row was hiding, this fix shouldn't be needed on Windows)
              old_value = (expanded_last_last_cell_row && expanded_last_last_cell_row[column]).to_i
              if OS.windows? && old_value == -1 && value >= 0
                Glimmer::Config.logger.error('Switching a progress bar value from -1 to a positive value is not supported on Windows')
                cell_row = cell_row_for(row)
                if cell_row.is_a?(Array)
                  cell_row[compound_column_index_for(column)] = -1
                else
                  attribute = column_attributes[column]
                  cell_row.send("#{attribute}=", -1)
                end
                ::LibUI.new_table_value_int(old_value)
              else
                ::LibUI.new_table_value_int((the_cell).to_i)
              end
            when Column::BackgroundColorColumnProxy
              background_color = Glimmer::LibUI.interpret_color(the_cell) || {r: 255, g: 255, b: 255}
              ::LibUI.new_table_value_color(background_color[:r] / 255.0, background_color[:g] / 255.0, background_color[:b] / 255.0, background_color[:a] || 1.0)
            when :color
              color = Glimmer::LibUI.interpret_color(the_cell) || {r: 0, g: 0, b: 0}
              ::LibUI.new_table_value_color(color[:r] / 255.0, color[:g] / 255.0, color[:b] / 255.0, color[:a] || 1.0)
            end
          end
          @model_handler.SetCellValue = fiddle_closure_block_caller(0, [1, 1, 4, 4, 1]) do |_, _, row, column, val|
            table_cell_row = cell_row_for(row)
            case @columns[column]
            when Column::TextColumnProxy
              column = @columns[column].index
              if table_cell_row.is_a?(Array)
                table_cell_row[column] = ::LibUI.table_value_string(val).to_s
              else
                attribute = column_attributes[column]
                table_cell_row.send("#{attribute}=", ::LibUI.table_value_string(val).to_s)
              end
            when Column::TextColorColumnProxy
              column = @columns[column].index
              if table_cell_row.is_a?(Array)
                table_cell_row[column] ||= []
                table_cell_row[column][0] = ::LibUI.table_value_string(val).to_s
              else
                attribute = column_attributes[column]
                table_cell_row.send("#{attribute}=", []) unless table_cell_row.send(attribute)
                table_cell_row.send(attribute)[0] = ::LibUI.table_value_string(val).to_s
              end
            when :text
              column = @columns[column - 1].index
              if table_cell_row.is_a?(Array)
                table_cell_row[column] ||= []
                table_cell_row[column][1] = ::LibUI.table_value_string(val).to_s
              else
                attribute = column_attributes[column]
                table_cell_row.send("#{attribute}=", []) unless table_cell_row.send(attribute)
                table_cell_row.send(attribute)[1] = ::LibUI.table_value_string(val).to_s
              end
            when Column::ButtonColumnProxy
              @columns[column].notify_custom_listeners('on_clicked', row)
            when Column::CheckboxColumnProxy
              column = @columns[column].index
              if table_cell_row.is_a?(Array)
                table_cell_row[column] = ::LibUI.table_value_int(val).to_i == 1
              else
                attribute = column_attributes[column]
                table_cell_row.send("#{attribute}=", ::LibUI.table_value_int(val).to_i == 1)
              end
            when Column::CheckboxTextColumnProxy, Column::CheckboxTextColorColumnProxy
              column = @columns[column].index
              if table_cell_row.is_a?(Array)
                table_cell_row[column] ||= []
                table_cell_row[column][0] = ::LibUI.table_value_int(val).to_i == 1
              else
                attribute = column_attributes[column]
                table_cell_row.send("#{attribute}=", []) unless table_cell_row.send(attribute)
                table_cell_row.send(attribute)[0] = ::LibUI.table_value_int(val).to_i == 1
              end
            end
            notify_custom_listeners('on_edited', row, table_cell_row)
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

          if !@applied_windows_fix && OS.windows?
            @applied_windows_fix = true
            apply_windows_fix
          end
        end
        
        def clear_cached_cell_rows
          @cached_cell_rows = nil
          @cached_cell_rows_size = nil
          @cached_cell_rows_enumerator_index = nil
        end
        
        def clear_cached_last_cell_rows
          @cached_last_cell_rows = nil
          @cached_last_cell_rows_size = nil
          @cached_last_cell_rows_enumerator_index = nil
        end
        
        def clear_cached_last_last_cell_rows
          @cached_last_last_cell_rows = nil
          @cached_last_last_cell_rows_size = nil
          @cached_last_last_cell_rows_enumerator_index = nil
        end
        
        def next_column_index
          @next_column_index ||= -1
          @next_column_index += 1
        end
        
        def register_cell_rows_observer
          # TODO update all the each_with_index calls below to work differently when value is an Enumerator
          # Perhaps, call ::LibUI.table_model_row_inserted(model, row) not from here, yet from the place where
          # we call `next` on the Enumerator to grab more elements
          # There will need to be extra intelligence for figuring out when to delete instead of
          # deleting a million rows when a change occurs
          @cell_rows_observer = Glimmer::DataBinding::Observer.proc do |new_cell_rows|
            if !@last_cell_rows.nil? # not initial load of table
              if @cell_rows.size < @last_cell_rows.size
                # TODO avoid inefficient delete/change notifications by only updating cells that need updates (only cells that have been displayed in CellValue)
                # instead of updating everything
                @last_cell_rows.each_with_index do |old_row_data, row|
                  new_row_data = cell_row_for(row)
                  if old_row_data != new_row_data && model
                    ::LibUI.table_model_row_changed(model, row)
                    notify_custom_listeners('on_changed', row, :changed, new_row_data)
                  end
                end
                count_of_cells_to_delete = @last_cell_rows.size - @cell_rows.size
                count_of_cells_to_delete.times do |n|
                  row = @last_cell_rows.size - n - 1
                  if model
                    ::LibUI.table_model_row_deleted(model, row)
                    notify_custom_listeners('on_changed', row, :deleted, last_cell_row_for(row))
                  end
                end
              elsif @cell_rows.size > @last_cell_rows.size
                (@cell_rows.size - @last_cell_rows.size).times do |n|
                  row = @last_cell_rows.size + n
                  if model
                    ::LibUI.table_model_row_inserted(model, row)
                    notify_custom_listeners('on_changed', row, :inserted, cell_row_for(row))
                  end
                end
                # TODO avoid inefficient insert/change notifications by only updating cells that need updates (only cells that have been displayed in CellValue)
                # instead of updating everything
                @cell_rows.each_with_index do |new_row_data, row|
                  if new_row_data != last_cell_row_for(row) && model
                    ::LibUI.table_model_row_changed(model, row)
                    notify_custom_listeners('on_changed', row, :changed, new_row_data)
                  end
                end
              elsif @cell_rows != @last_cell_rows
                @cell_rows.each_with_index do |new_row_data, row|
                  if new_row_data != last_cell_row_for(row) && model
                    ::LibUI.table_model_row_changed(model, row)
                    notify_custom_listeners('on_changed', row, :changed, new_row_data)
                  end
                end
              end
            end
            # TODO look into performance implications of deep cloning an entire array,
            # which wastes time looping through all elements even if we are displaying about
            # 20 of them only at the moment, thus preventing lazy loading from happening
            # Consider alternatively caching rows per index when needed instead
            # This seems to add about a full second to certain apps, especially when using enumerators
            # to avoid loading everything at once
            
            dup_last_last_cell_rows if OS.windows?
            dup_last_cell_rows
            
            if !@applied_windows_fix_on_first_cell_rows_update && OS.windows?
              @applied_windows_fix_on_first_cell_rows_update = true
              apply_windows_fix
            end
          end
          @cell_rows_observer_registration = @cell_rows_observer.observe(self, :cell_rows, recursive: true, ignore_frozen: true, attribute_writer_type: [:attribute=, :set_attribute])
          @cell_rows_observer.call
        end

        def apply_windows_fix
          # TODO will this require that @cell_rows_observer is called with queue_main too to avoid issue with multiple immediate model updates breaking this?
          Glimmer::LibUI.queue_main do
            new_row = @columns&.select {|column| column.is_a?(Column)}&.map {|column| column.class.default_value}
            if new_row && !@cell_rows.is_a?(Enumerator)
              @cell_rows << new_row
              @cell_rows.pop
            end
          end
        end
        
        def register_listeners
          # register accumulated listeners after table content is closed
          @table_listeners&.each do |listener_name, listener|
            handle_listener(listener_name, &listener)
          end
          handle_listener('on_selection_changed') do |myself, selection, added_selection, removed_selection|
            @old_selection = selection
          end
        end
        
        def register_column_listeners
          # register accumulated column listeners after table content is closed
          return if @columns.nil? || @columns.empty?
          if @columns.any? {|column| column.is_a?(Column)}
            ::LibUI.table_header_on_clicked(@libui) do |_, column_index|
              actual_columns = @columns.select {|column| column.is_a?(Column)}
              column = actual_columns[column_index]
              if column.is_a?(Column) && !column.is_a?(Column::ButtonColumnProxy)
                column_listeners = column.column_listeners_for('on_clicked')
                column_listeners.each do |column_listener|
                  column_listener.call(column, column_index)
                end
              end
            end
          end
        end
        
        def configure_selection_mode
          send_to_libui('selection_mode=', @selection_mode) if @selection_mode
        end
        
        def configure_selection
          self.selection = @selection
        end
        
        def configure_header_visible
          self.header_visible = @header_visible
        end
        
        def configure_column_sort_indicators
          column_proxies.each(&:configure_sort_indicator)
        end
        
        def configure_sorting
          if sortable?
            columns.each do |column_object|
              next unless column_object.is_a?(Column) && !column_object.is_a?(Column::ButtonColumnProxy)
              column_object.on_clicked do |column_proxy, column|
                sort_by_column(column_proxy, column)
              end
            end
          end
        end
        
        def sort_by_column(column_proxy, column)
          return unless sortable? && cell_rows.is_a?(Array)
          old_selection = backup_selection
          column_proxy.toggle_sort_indicator
          cell_rows.sort_by! {|table_cell_row| DEFAULT_COLUMN_SORT_BLOCK.call(table_cell_row, column, self) }
          cell_rows.reverse! if column_proxy.sort_indicator == :descending
          restore_selection(old_selection)
        end
        
        def backup_selection
          if selection_mode == ::LibUI::TableSelectionModeZeroOrMany
            selected_rows = selection&.map { |row| cell_rows[row] }
          else
            selected_row = selection && cell_rows[selection]
          end
        end
        
        def restore_selection(old_selection)
          if selection_mode == ::LibUI::TableSelectionModeZeroOrMany
            selected_rows = old_selection
            self.selection = selected_rows&.map {|row_data| cell_rows.index(row_data) }
          else
            selected_row = old_selection
            self.selection = cell_rows.index(selected_row)
          end
        end
        
      end
    end
  end
end
