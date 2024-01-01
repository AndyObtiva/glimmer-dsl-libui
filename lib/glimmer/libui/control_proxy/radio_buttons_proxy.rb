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

module Glimmer
  module LibUI
    class ControlProxy
      # Proxy for LibUI radio buttons objects
      #
      # Follows the Proxy Design Pattern
      class RadioButtonsProxy < ControlProxy
        def items(*values)
          values = values.first if values.first.is_a?(Array)
          if values.empty?
            @values
          else
            @values = values
            @values.each { |value| append value }
          end
        end
        alias set_items items
        alias items= items
        
        def selected_item(value = nil)
          if value.nil?
            items[selected]
          else
            self.selected = items.index(value) || -1
          end
        end
        alias set_selected_item selected_item
        alias selected_item= selected_item
        
        def selected=(value = nil)
          value ||= -1
          super(value)
        end
        
        def data_bind_write(property, model_binding)
          case property
          when 'selected'
            handle_listener('on_selected') { model_binding.call(selected) }
          when 'selected_item'
            handle_listener('on_selected') { model_binding.call(selected_item) }
          end
        end
      end
    end
  end
end
