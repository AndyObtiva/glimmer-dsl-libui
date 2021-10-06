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
require 'glimmer/libui/control_proxy/area_proxy'
require 'glimmer/libui/parent'

module Glimmer
  module LibUI
    class ControlProxy
      # Proxy for LibUI open type tag objects
      #
      # Follows the Proxy Design Pattern
      class OpenTypeTagProxy < ControlProxy
        def destroy
          @parent_proxy&.children&.delete(self)
          ControlProxy.control_proxies.delete(self)
        end
        
        def redraw
          @parent_proxy.redraw
        end
        
        private
        
        def build_control
          tag_args = @args.dup
          tag_args[0] = ordinalize(tag_args[0])
          tag_args[1] = ordinalize(tag_args[1])
          tag_args[2] = ordinalize(tag_args[2])
          tag_args[3] = ordinalize(tag_args[3])
          ::LibUI.open_type_features_add(@parent_proxy.libui, *tag_args)
        end
        
        def ordinalize(arg)
          arg.is_a?(String) ? arg.ord : arg
        end
      end
    end
  end
end
