# Copyright (c) 2021-2025 Andy Maleh
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
require 'glimmer/libui/control_proxy/dual_column'
require 'glimmer/libui/control_proxy/editable_column'

module Glimmer
  module LibUI
    class ControlProxy
      module Column
        # Proxy for LibUI checkbox text column objects
        #
        # Follows the Proxy Design Pattern
        class CheckboxTextColumnProxy < ControlProxy
          class << self
            def default_value
              [false, '']
            end
          end
          
          include Column
          include DualColumn
          include EditableColumn
          
          def editable_checkbox(value = nil)
            if value.nil?
              @editable_checkbox = false if @editable_checkbox.nil?
              @editable_checkbox
            else
              @editable_checkbox = !!value
            end
          end
          alias editable_checkbox= editable_checkbox
          alias set_editable_checkbox editable_checkbox
          alias editable_checkbox? editable_checkbox
    
          def editable_text(value = nil)
            if value.nil?
              @editable_text = false if @editable_text.nil?
              @editable_text
            else
              @editable_text = !!value
            end
          end
          alias editable_text= editable_text
          alias set_editable_text editable_text
          alias editable_text? editable_text
    
          private
          
          def build_control
            @parent_proxy.append_checkbox_text_column(name, column_index, editable_checkbox_value, second_column_index, editable_text_value)
          end
          
          def editable_checkbox_value
            (@parent_proxy.editable? || editable? || editable_checkbox?) ? -2 : -1
          end
          
          def editable_text_value
            (@parent_proxy.editable? || editable? || editable_text?) ? -2 : -1
          end
        end
      end
    end
  end
end
