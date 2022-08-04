class RefinedTable
  include Glimmer::LibUI::CustomControl
  
  option :model_array, default: []
  option :table_columns, default: []
  option :table_editable, default: false
  option :per_page, default: 10
  option :page, default: 1
  option :visible_page_count, default: true
  
  attr_accessor :filtered_model_array, :filter_query, :filter_query_page_stack, :paginated_model_array
  
  before_body do
    @filter_query = ''
    @filter_query_page_stack = {}
    @filtered_model_array = model_array.dup
    @filtered_model_array_stack = {@filter_query => @filtered_model_array}
    self.page = correct_page(page)
    paginate_model_array
  end
  
  body {
    vertical_box {
      table_filter

      table_paginator if page_count > 1
      
      @table = table {
        table_columns.each do |column_name, column_details|
          editable_value = on_clicked_value = nil
          if column_details.is_a?(Symbol) || column_details.is_a?(String)
            column_type = column_details
          elsif column_details.is_a?(Hash)
            column_type = column_details.keys.first
            editable_value = column_details.values.first[:editable] || column_details.values.first['editable']
            on_clicked_value = column_details.values.first[:on_clicked] || column_details.values.first['on_clicked']
          end
          
          send("#{column_type}_column", column_name) {
            editable editable_value unless editable_value.nil?
            on_clicked(&on_clicked_value) unless on_clicked_value.nil?
          }
        end
  
        editable table_editable
        cell_rows <=> [self, :paginated_model_array]
      }
    }
  }
  
  def table_filter
    search_entry {
      stretchy false
      text <=> [self, :filter_query,
        before_write: ->(new_filter_query) {
          if new_filter_query != filter_query
            if !@filtered_model_array_stack.key?(new_filter_query)
              @filtered_model_array_stack[new_filter_query] = model_array.dup.filter do |model|
                @table.expand([model])[0].any? do |attribute_value|
                  attribute_value.to_s.downcase.include?(new_filter_query.downcase)
                end
              end
            end
            @filtered_model_array = @filtered_model_array_stack[new_filter_query]
            if new_filter_query.size > filter_query.size
              @filter_query_page_stack[filter_query] = page
            end
            self.page = @filter_query_page_stack[new_filter_query] || correct_page(page)
            paginate_model_array
          end
        }
      ]
    }
  end
  
  def table_paginator
    horizontal_box {
      stretchy false
      
      button('<<') {
        enabled <= [self, :page, on_read: ->(val) {val > 1}]
        
        on_clicked do
          unless self.page == 0
            self.page = 1
            paginate_model_array
          end
        end
      }
      
      button('<') {
        enabled <= [self, :page, on_read: ->(val) {val > 1}]
        
        on_clicked do
          unless self.page == 0
            self.page = [page - 1, 1].max
            paginate_model_array
          end
        end
      }
      
      entry {
        text <=> [self, :page,
                  on_read: :to_s,
                  on_write: ->(val) { correct_page(val.to_i) },
                  after_write: ->(val) { paginate_model_array },
                 ]
      }
      
      if visible_page_count
        label {
          text <= [self, :paginated_model_array, on_read: ->(val) {"of #{page_count} pages"}]
        }
      end
      
      button('>') {
        enabled <= [self, :page, on_read: ->(val) {val < page_count}]
        
        on_clicked do
          unless self.page == 0
            self.page = [page + 1, page_count].min
            paginate_model_array
          end
        end
      }
      
      button('>>') {
        enabled <= [self, :page, on_read: ->(val) {val < page_count}]
        
        on_clicked do
          unless self.page == 0
            self.page = page_count
            paginate_model_array
          end
        end
      }
    }
  end
  
  def paginate_model_array
    self.paginated_model_array = filtered_model_array[index, limit]
  end
  
  def index
    [per_page * (page - 1), 0].max
  end
  
  def limit
    [(filtered_model_array.count - index), per_page].min
  end
  
  def page_count
    (filtered_model_array.count.to_f / per_page.to_f).ceil
  end
  
  def correct_page(page)
    [[page, 1].max, page_count].min
  end
  
  # Ensure proxying properties to @table if body_root (vertical_box) doesn't support them
  
  def respond_to?(method_name, *args, &block)
    super || @table&.respond_to?(method_name, *args, &block)
  end
  
  def method_missing(method_name, *args, &block)
    if @table&.respond_to?(method_name, *args, &block)
      @table&.send(method_name, *args, &block)
    else
      super
    end
  end
end
