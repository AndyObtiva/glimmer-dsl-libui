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

require 'glimmer/libui/control_proxy'
require 'glimmer/libui/parent'

module Glimmer
  module LibUI
    class ControlProxy
      # Proxy for LibUI menu objects
      #
      # Follows the Proxy Design Pattern
      class MenuProxy < ControlProxy
        include Parent
        
        DEFAULT_TEXT = ''
        
        private
        
        def build_control
          construction_args = @args.dup
          construction_args[0] = DEFAULT_TEXT if construction_args.size == 0
          @libui = ControlProxy.new_control(@keyword, construction_args)
        end
      end
    end
  end
end
