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

require 'glimmer/libui/control_proxy/menu_item_proxy'

module Glimmer
  module LibUI
    class ControlProxy
      class MenuItemProxy < ControlProxy
        # Proxy for LibUI quit menu item object
        #
        # Follows the Proxy Design Pattern
        class QuitMenuItemProxy < MenuItemProxy
          def can_handle_listener?(listener_name)
            listener_name == 'on_clicked' || super
          end
        
          def handle_listener(listener_name, &listener)
            if listener_name == 'on_clicked'
              @on_clicked_listeners ||= []
              @on_clicked_listeners << listener
              @default_behavior_listener ||= Proc.new do
                return_value = nil
                @on_clicked_listeners.each do |l|
                  return_value = l.call(self)
                  break if return_value.is_a?(Numeric)
                end
                if return_value.is_a?(Numeric)
                  return_value
                else
                  ControlProxy.main_window_proxy&.destroy
                  ::LibUI.quit
#                   0
                  1
                end
              end.tap do |default_behavior_listener|
                ::LibUI.on_should_quit(&default_behavior_listener)
              end
            end
          end
          
          def destroy
            @on_clicked_listeners&.clear
            super
          end
        
          private
          
          def build_control
            @libui = @parent_proxy.append_quit_item(*@args)
            # setup default on_clicked listener if no on_clicked listeners are setup
            handle_listener('on_clicked') {} if @on_clicked_listeners.nil? || @on_clicked_listeners.empty?
          end
        end
      end
    end
  end
end
