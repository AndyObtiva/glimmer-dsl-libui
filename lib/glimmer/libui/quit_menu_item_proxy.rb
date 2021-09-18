# Copyright (c) 2021 Andy Maleh
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

require 'glimmer/libui/menu_item_proxy'

module Glimmer
  module LibUI
    # Proxy for LibUI quit menu item object
    #
    # Follows the Proxy Design Pattern
    class QuitMenuItemProxy < MenuItemProxy
      def can_handle_listener?(listener_name)
        listener_name == 'on_clicked' || super
      end
    
      def handle_listener(listener_name, &listener)
        if listener_name == 'on_clicked'
          @default_behavior_listener = Proc.new do
            return_value = listener.call(self)
            if return_value.is_a?(Numeric)
              return_value
            else
              destroy
              ::LibUI.quit
              0
            end
          end
          ::LibUI.on_should_quit(&@default_behavior_listener)
        end
      end
    
      private
      
      def build_control
        @libui = @parent_proxy.append_quit_item(*@args)
        handle_listener('on_clicked') do
          destroy # TODO look into finding a way to destroy main window
          ::LibUI.quit
          0
        end
      end
    end
  end
end
