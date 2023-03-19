require 'glimmer-dsl-libui'

class BasicTableSelection
  TableColumnPresenter = Struct.new(:name,
                                    :column,
                                    :sort_indicator,
                                    :table_presenter,
                                    keyword_init: true) do
    def toggle_sort_indicator
      self.sort_indicator = self.sort_indicator != :ascending ? :ascending : :descending
    end
    
    def sort
      selected_row = table_presenter.selected_row
      toggle_sort_indicator
      table_presenter.data.sort_by! { |row_data| row_data[column] }
      table_presenter.data.reverse! if sort_indicator == :descending
      table_presenter.selection = table_presenter.data.index(selected_row)
    end
  end
                                  
  TablePresenter = Struct.new(:data,
                              :column_names,
                              :selection_mode,
                              :selection,
                              :header_visible,
                              keyword_init: true) do
    def selection_items
      data.size.times.map { |row| "Row #{row} Selection" }
    end
    
    def toggle_header_visible
      self.header_visible = !(header_visible.nil? || header_visible)
    end
    
    def column_presenters
      @column_presenters ||= column_names.each_with_index.map do |column_name, column|
        TableColumnPresenter.new(name: column_name, column: column, table_presenter: self)
      end
    end
    
    def selected_row
      selection && data[selection]
    end
  end
  
  include Glimmer::LibUI::Application
  
  before_body do
    data = [
      %w[cat meow],
      %w[dog woof],
      %w[chicken cock-a-doodle-doo],
      %w[horse neigh],
      %w[cow moo]
    ]
    @one_table_presenter = TablePresenter.new(
      data: data.dup,
      column_names: ['Name', 'Description'],
      selection_mode: :one, # other values are :zero_or_many , :zero_or_one, :none (default is :zero_or_one if not specified)
      selection: 2, # initial selection row index (could be nil too or just left off, defaulting to 0)
      header_visible: nil, # defaults to true
    )
    @zero_or_one_table_presenter = TablePresenter.new(
      data: data.dup,
      column_names: ['Name', 'Description'],
      selection_mode: :zero_or_one, # other values are :zero_or_many , :one, :none (default is :zero_or_one if not specified)
      selection: nil, # initial selection row index (could be an integer too or just left off, defaulting to nil)
      header_visible: nil, # defaults to true
    )
    @none_table_presenter = TablePresenter.new(
      data: data.dup,
      column_names: ['Name', 'Description'],
      selection_mode: :none, # other values are :zero_or_many , :zero_or_one, :one (default is :zero_or_one if not specified)
      selection: nil, # defaults to nil
      header_visible: nil, # defaults to true
    )
  end
  
  body {
    window('Basic Table Selection', 400, 300) {
      tab {
        tab_item('One') {
          vertical_box {
            vertical_box {
              stretchy false
              
              @one_table_selection_radio_buttons = radio_buttons {
                items @one_table_presenter.selection_items
                selected <=> [@one_table_presenter, :selection]
              }
            }
            
            button('Toggle Table Header Visibility') {
              stretchy false
              
              on_clicked do
                @one_table_presenter.toggle_header_visible
              end
            }
            
            @one_table = table {
              @one_table_presenter.column_presenters.each do |column_presenter|
                text_column(column_presenter.name) {
                  sort_indicator <=> [column_presenter, :sort_indicator]
                  
                  on_clicked do |tc, column|
                    puts "Clicked column #{column}: #{tc.name}"
                    column_presenter.sort
                  end
                }
              end
        
              cell_rows @one_table_presenter.data
              selection_mode <= [@one_table_presenter, :selection_mode]
              selection <=> [@one_table_presenter, :selection]
              header_visible <= [@one_table_presenter, :header_visible]
        
              on_row_clicked do |t, row|
                puts "Row Clicked: #{row}"
              end
        
              on_row_double_clicked do |t, row|
                puts "Row Double Clicked: #{row}"
              end
        
              on_selection_changed do |t, selection, added_selection, removed_selection|
                # selection is an array or nil if selection mode is zero_or_many
                # otherwise, selection is a single index integer or nil when not selected
                puts "Selection Changed: #{selection.inspect}"
                puts "Added Selection: #{added_selection.inspect}"
                puts "Removed Selection: #{removed_selection.inspect}"
              end
            }
          }
        }
        
        tab_item('Zero-Or-One') {
          vertical_box {
            vertical_box {
              stretchy false
              
              @zero_or_one_table_selection_radio_buttons = radio_buttons {
                items @zero_or_one_table_presenter.selection_items
                selected <=> [@zero_or_one_table_presenter, :selection]
              }
            }
            
            button('Toggle Table Header Visibility') {
              stretchy false
              
              on_clicked do
                @zero_or_one_table_presenter.toggle_header_visible
              end
            }
            
            @zero_or_one_table = table {
              @zero_or_one_table_presenter.column_presenters.each do |column_presenter|
                text_column(column_presenter.name) {
                  sort_indicator <=> [column_presenter, :sort_indicator]
                  
                  on_clicked do |tc, column|
                    puts "Clicked column #{column}: #{tc.name}"
                    column_presenter.sort
                  end
                }
              end
        
              cell_rows @zero_or_one_table_presenter.data
              selection_mode <= [@zero_or_one_table_presenter, :selection_mode]
              selection <=> [@zero_or_one_table_presenter, :selection]
              header_visible <= [@zero_or_one_table_presenter, :header_visible]
        
              on_row_clicked do |t, row|
                puts "Row Clicked: #{row}"
              end
        
              on_row_double_clicked do |t, row|
                puts "Row Double Clicked: #{row}"
              end
        
              on_selection_changed do |t, selection, added_selection, removed_selection|
                # selection is an array or nil if selection mode is zero_or_many
                # otherwise, selection is a single index integer or nil when not selected
                puts "Selection Changed: #{selection.inspect}"
                puts "Added Selection: #{added_selection.inspect}"
                puts "Removed Selection: #{removed_selection.inspect}"
              end
            }
          }
        }
        
        tab_item('None') {
          vertical_box {
            button('Toggle Table Header Visibility') {
              stretchy false
              
              on_clicked do
                @none_table_presenter.toggle_header_visible
              end
            }
            
            @none_table = table {
              @none_table_presenter.column_presenters.each do |column_presenter|
                text_column(column_presenter.name) {
                  sort_indicator <=> [column_presenter, :sort_indicator]
                  
                  on_clicked do |tc, column|
                    puts "Clicked column #{column}: #{tc.name}"
                    column_presenter.sort
                  end
                }
              end
        
              cell_rows @none_table_presenter.data
              selection_mode <= [@none_table_presenter, :selection_mode]
              selection <=> [@none_table_presenter, :selection]
              header_visible <= [@none_table_presenter, :header_visible]
        
              on_row_clicked do |t, row|
                puts "Row Clicked: #{row}"
              end
        
              on_row_double_clicked do |t, row|
                puts "Row Double Clicked: #{row}"
              end
            }
          }
        }
        
      }
    }
  }
end

BasicTableSelection.launch
