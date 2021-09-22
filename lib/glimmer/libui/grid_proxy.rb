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
    class GridProxy < ControlProxy
      APPEND_PROPERTIES = %w[left top xspan yspan hexpand halign vexpand valign]
      
      def post_initialize_child(child)
        child.left = 0 if child.left.nil?
        child.top = 0 if child.top.nil?
        child.xspan = 1 if child.xspan.nil?
        child.yspan = 1 if child.yspan.nil?
        child.hexpand = false if child.hexpand.nil?
        child.halign = 0 if child.halign.nil?
        child.vexpand = false if child.vexpand.nil?
        child.valign = 0 if child.valign.nil?
        ::LibUI.grid_append(@libui, child.libui, child.left, child.top, child.xspan, child.yspan, ControlProxy.boolean_to_integer(child.hexpand), child.halign, ControlProxy.boolean_to_integer(child.vexpand), child.valign)
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
