class RefinedTable
  include Glimmer::LibUI::CustomControl
  
  option :model_array, default: []
  option :table_columns, default: []
  option :table_editable, default: false
  option :per_page, default: 10
  option :page, default: 1
  option :visible_page_count, default: false
  
  attr_accessor :filter_query, :filter_query_page_stack
  attr_accessor :filtered_model_array # filtered model array (intermediary, non-paginated)
  attr_accessor :refined_model_array # paginated filtered model array
  attr_reader :table_proxy
  
  before_body do
    init_model_array
  end
  
  after_body do
    observe(self, :model_array) do
      init_model_array
    end
    observe(self, :filter_query) do
      filter_model_array
    end
  end
  
  body {
    vertical_box {
      table_filter

      table_paginator if page_count > 1
      
      @table_proxy = table {
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
        cell_rows <=> [self, :refined_model_array]
      }
    }
  }
  
  def table_filter
    search_entry {
      stretchy false
      text <=> [self, :filter_query]
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
          text <= [self, :refined_model_array, on_read: ->(val) {"of #{page_count} pages"}]
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
  
  def init_model_array
    @last_filter_query = nil
    @filter_query ||= ''
    @filter_query_page_stack = {}
    @filtered_model_array = model_array.dup
    @filtered_model_array_stack = {'' => @filtered_model_array}
    self.page = correct_page(page)
    filter_model_array
  end
  
  def filter_model_array
    return unless @last_filter_query.nil? || filter_query != @last_filter_query
    if !@filtered_model_array_stack.key?(filter_query)
      @filtered_model_array_stack[filter_query] = model_array.dup.filter do |model|
        @table_proxy.expand([model])[0].any? do |attribute_value|
          attribute_value.to_s.downcase.include?(filter_query.downcase)
        end
      end
    end
    @filtered_model_array = @filtered_model_array_stack[filter_query]
    if @last_filter_query.nil? || filter_query.size > @last_filter_query.size
      @filter_query_page_stack[filter_query] = correct_page(page)
    end
    self.page = @filter_query_page_stack[filter_query] || correct_page(page)
    paginate_model_array
    @last_filter_query = filter_query
  end
  
  def paginate_model_array
    self.refined_model_array = filtered_model_array[index, limit]
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
  
  # Ensure proxying properties to @table_proxy if body_root (vertical_box) doesn't support them
  
  def respond_to?(method_name, *args, &block)
    super || @table_proxy&.respond_to?(method_name, *args, &block)
  end
  
  def method_missing(method_name, *args, &block)
    if @table_proxy&.respond_to?(method_name, *args, &block)
      @table_proxy&.send(method_name, *args, &block)
    else
      super
    end
  end
end
