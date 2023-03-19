require 'glimmer-dsl-libui'

class BasicTableSelection
  TablePresenter = Struct.new(:data, :selection_mode, :selection, :header_visible, keyword_init: true) do
    def selection_items
      data.size.times.map { |row| "Row #{row} Selection" }
    end
    
    def toggle_header_visible
      self.header_visible = !(header_visible.nil? || header_visible)
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
      selection_mode: :one, # other values are :zero_or_many , :zero_or_one, :none (default is :zero_or_one if not specified)
      selection: 2, # initial selection row index (could be nil too or just left off, defaulting to 0)
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
              text_column('Animal') {
                # sort_indicator :descending # (optional) can be :ascending, :descending, or nil (default)
                
                on_clicked do |tc, column|
                  sort_one_table_column(tc, column)
                end
              }
              text_column('Description') {
                # sort_indicator :descending # (optional) can be :ascending, :descending, or nil (default)
                
                on_clicked do |tc, column|
                  sort_one_table_column(tc, column)
                end
              }
        
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
        
      }
    }
  }
  
  def sort_one_table_column(tc, column)
    puts "Clicked column #{column}: #{tc.name}"
    selected_row = @one_table_presenter.selection && @one_table_presenter.data[@one_table.selection]
    tc.toggle_sort_indicator
    @one_table_presenter.data.sort_by! { |row_data| row_data[column] }
    @one_table_presenter.data.reverse! if tc.sort_indicator == :descending
    @one_table_presenter.selection = @one_table_presenter.data.index(selected_row)
  end
end

BasicTableSelection.launch
