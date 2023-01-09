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
          @parent_proxy.columns.select {|c| c.is_a?(Column)}.index(self)
        end
      end
    end
  end
end

Dir[File.expand_path("./#{File.basename(__FILE__, '.rb')}/*.rb", __dir__)].each {|f| require f}
