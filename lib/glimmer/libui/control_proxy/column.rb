# Copyright (c) 2021-2023 Andy Maleh
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

module Glimmer
  module LibUI
    class ControlProxy
      # Common logic for all column proxy objects
      module Column
        class << self
          # subclasses may override to provide a valid default value like a blank image for image columns and false for checkbox
          def default_value
            nil
          end
        end

        def initialize(keyword, parent, args, &block)
          @keyword = keyword
          @parent_proxy = parent
          @args = args
          @block = block
          @enabled = true
          post_add_content if @block.nil?
        end
        
        def name
          @args.first
        end
        
        # column index used in table append column API call
        # expanded to ensure DualColumn index accounts for two columns acting as one
        def column_index
          @column_index ||= @parent_proxy.send(:next_column_index)
        end
        
        # actual index within table columns (disregarding extra fillings that account for DualColumn instances)
        def index
          @parent_proxy.column_proxies.index(self)
        end
        
        def other_columns
          @parent_proxy.column_proxies.reject {|c| c == self}
        end
        
        def sort_indicator
          return @sort_indicator if !@content_added
          
          result = ::LibUI.table_header_sort_indicator(@parent_proxy.libui, index)
          LibUI.integer_to_column_sort_indicator(result)
        end
        
        def sort_indicator=(*args)
          options = args.last.is_a?(Hash) ? args.pop : {reset_columns: true}
          value = args.first
          @sort_indicator = value
          return @sort_indicator if !@content_added
          
          other_columns.each { |c| c.set_sort_indicator(nil, reset_columns: false) } if options[:reset_columns]
          value = LibUI.column_sort_indicator_to_integer(value)
          ::LibUI.table_header_set_sort_indicator(@parent_proxy.libui, index, value)
        end
        alias set_sort_indicator sort_indicator=
        
        def toggle_sort_indicator(value = nil)
          if value.nil?
            self.sort_indicator = self.sort_indicator != :ascending ? :ascending : :descending
          else
            self.sort_indicator = value
          end
        end
          
        def can_handle_listener?(listener_name)
          listener_name == 'on_clicked'
        end
        
        def handle_listener(listener_name, &listener)
          column_listeners_for(listener_name) << listener
        end
      
        def column_listeners
          @column_listeners ||= {}
        end
        
        def column_listeners_for(listener_name)
          column_listeners[listener_name] ||= []
        end
        
        def configure_sort_indicator
          set_sort_indicator(@sort_indicator, reset_columns: false)
        end
      end
    end
  end
end

Dir[File.expand_path("./#{File.basename(__FILE__, '.rb')}/*.rb", __dir__)].each {|f| require f}
