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

require 'glimmer/libui/control_proxy'

module Glimmer
  module LibUI
    # Proxy for LibUI Window objects
    #
    # Follows the Proxy Design Pattern
    class WindowProxy < ControlProxy
      def post_initialize_child(child)
        ::LibUI.window_set_child(@libui, child.libui)
      end
    
      def show
        send_to_libui('show')
        unless @shown_at_least_once
          @shown_at_least_once = true
          ::LibUI.main
          ::LibUI.quit
        end
      end
      
      def handle_listener(listener_name, &listener)
        if listener_name == 'on_closing'
          default_behavior_listener = Proc.new do
            return_value = listener.call
            if return_value.is_a?(Numeric)
              return_value
            else
              destroy
              ::LibUI.quit
              0
            end
          end
        end
        super(listener_name, &default_behavior_listener)
      end
    
      private
      
      def build_control
        ::LibUI.init
        super.tap do
          handle_listener('on_closing') do
            destroy
            ::LibUI.quit
            0
          end
        end
      end
    end
  end
end
