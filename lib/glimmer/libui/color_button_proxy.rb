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
    # Proxy for LibUI color button objects
    #
    # Follows the Proxy Design Pattern
    class ColorButtonProxy < ControlProxy
      def color
        @red ||= Fiddle::Pointer.malloc(8) # double
        @green ||= Fiddle::Pointer.malloc(8) # double
        @blue ||= Fiddle::Pointer.malloc(8) # double
        @alpha ||= Fiddle::Pointer.malloc(8) # double
        ::LibUI.color_button_color(@libui, @red, @green, @blue, @alpha)
        [@red[0, 8].unpack1('d') * 255.0, @green[0, 8].unpack1('d') * 255.0, @blue[0, 8].unpack1('d') * 255.0, @alpha[0, 8].unpack1('d')]
      end
      
      def red
        color[0]
      end
      
      def green
        color[1]
      end
      
      def blue
        color[2]
      end
      
      def alpha
        color[3]
      end
      
      def destroy
        Fiddle.free @red unless @red.nil?
        Fiddle.free @green unless @green.nil?
        Fiddle.free @blue unless @blue.nil?
        Fiddle.free @alpha unless @alpha.nil?
        super
      end
    end
  end
end
