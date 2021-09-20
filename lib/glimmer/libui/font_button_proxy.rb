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
    # Proxy for LibUI font button objects
    #
    # Follows the Proxy Design Pattern
    class FontButtonProxy < ControlProxy
      def font
        @font_descriptor ||= ::LibUI::FFI::FontDescriptor.malloc
        ::LibUI.font_button_font(@libui, @font_descriptor)
        {
          family: @font_descriptor.Family.to_s,
          size: @font_descriptor.Size,
          weight: @font_descriptor.Weight,
          italic: @font_descriptor.Italic,
          stretch: @font_descriptor.Stretch
        }
      end
      
      def destroy
        ::LibUI.free_font_button_font(@font_descriptor) unless @font_descriptor.nil?
        super
      end
    end
  end
end
