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
      class FormProxy < ControlProxy
        APPEND_PROPERTIES = %w[label stretchy]
        
        def post_initialize_child(child)
          child.label = '' if child.label.nil?
          child.stretchy = true if child.stretchy.nil?
          ::LibUI.form_append(@libui, child.label, child.libui, Glimmer::LibUI.boolean_to_integer(child.stretchy))
          children << child
        end
        
        def children
          @children ||= []
        end
        
        def destroy_child(child)
          child.deregister_all_custom_listeners
          ::LibUI.send("form_delete", @libui, children.index(child))
          ControlProxy.control_proxies.delete(child)
          children.delete(child)
        end
        
        private
        
        def build_control
          super.tap do
            self.padded = true
          end
        end
      end
    end
  end
end
