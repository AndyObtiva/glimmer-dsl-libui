# Copyright (c) 2021-2022 Andy Maleh
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

require 'glimmer/libui/control_proxy/menu_item_proxy'

module Glimmer
  module LibUI
    class ControlProxy
      class MenuItemProxy < ControlProxy
        # Proxy for LibUI radio menu item object
        #
        # Follows the Proxy Design Pattern
        class RadioMenuItemProxy < MenuItemProxy
          def initialize(keyword, parent, args, &block)
            @last_checked = nil
            super
          end
        
          def checked(value = nil)
            if value.nil?
              super()
            else
              super
              if Glimmer::LibUI.integer_to_boolean(value, allow_nil: false) != Glimmer::LibUI.integer_to_boolean(@last_checked, allow_nil: false)
                if Glimmer::LibUI.integer_to_boolean(value)
                  (@parent_proxy.children - [self]).select {|c| c.is_a?(MenuItemProxy)}.each do |menu_item|
                    menu_item.checked = false
                  end
                end
                @last_checked = checked
              end
            end
          end
          alias checked? checked
          alias set_checked checked
          alias checked= checked
          
          def handle_listener(listener_name, &listener)
            if listener_name.to_s == 'on_clicked'
              radio_listener = Proc.new do
                self.checked = true
                listener.call(self)
              end
              super(listener_name, &radio_listener)
            else
              super
            end
          end
        
          def data_bind_write(property, model_binding)
            handle_listener('on_clicked') { model_binding.call(checked) } if property == 'checked'
          end
        
          private
          
          def build_control
            @libui = @parent_proxy.append_check_item(*@args)
          end
        end
      end
    end
  end
end
