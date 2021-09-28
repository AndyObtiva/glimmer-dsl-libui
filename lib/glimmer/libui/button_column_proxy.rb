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
require 'glimmer/libui/column'
require 'glimmer/libui/enableable_column'

module Glimmer
  module LibUI
    # Proxy for LibUI button column objects
    #
    # Follows the Proxy Design Pattern
    class ButtonColumnProxy < ControlProxy
      include Column
      include EnableableColumn
      
      def on_clicked(&block)
        # TODO consider generalizing into custom listeners and moving to ControlProxy
        @on_clicked_procs ||= []
        if block.nil?
          @on_clicked_procs
        else
          @on_clicked_procs << block
          block
        end
      end
      
      def can_handle_listener?(listener_name)
        listener_name == 'on_clicked' || super
      end
      
      def handle_listener(listener_name, &listener)
        case listener_name
        when 'on_clicked'
          on_clicked(&listener)
        else
          super
        end
      end
      
      def notify_listeners(listener_name, *args)
        @on_clicked_procs&.each do |on_clicked_proc|
          on_clicked_proc.call(*args)
        end
      end
          
      private
      
      def build_control
        @parent_proxy.append_button_column(name, column_index, enabled_value)
      end
    end
  end
end
