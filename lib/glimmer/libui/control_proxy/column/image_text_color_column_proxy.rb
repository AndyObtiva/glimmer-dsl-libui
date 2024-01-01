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
require 'glimmer/libui/control_proxy/column'
require 'glimmer/libui/control_proxy/triple_column'
require 'glimmer/libui/control_proxy/editable_column'

module Glimmer
  module LibUI
    class ControlProxy
      module Column
        # Proxy for LibUI image text color column objects
        #
        # Follows the Proxy Design Pattern
        class ImageTextColorColumnProxy < ControlProxy
          class << self
            def default_value
              [Glimmer::LibUI::ICON, '', :black]
            end
          end
          
          include Column
          include TripleColumn
          include EditableColumn
              
          private
          
          def build_control
            table_text_column_optional_params = ::LibUI::FFI::TableTextColumnOptionalParams.malloc
            table_text_column_optional_params.ColorModelColumn = third_column_index
            @parent_proxy.append_image_text_column(name, column_index, second_column_index, editable_value, table_text_column_optional_params)
          end
        end
      end
    end
  end
end
