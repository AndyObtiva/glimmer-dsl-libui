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
    class ControlProxy
      # Proxy for LibUI color button objects
      #
      # Follows the Proxy Design Pattern
      class ColorButtonProxy < ControlProxy
        def color(value = nil)
          # TODO support hex color value
          if value.nil?
            @red ||= Fiddle::Pointer.malloc(8) # double
            @green ||= Fiddle::Pointer.malloc(8) # double
            @blue ||= Fiddle::Pointer.malloc(8) # double
            @alpha ||= Fiddle::Pointer.malloc(8) # double
            ::LibUI.color_button_color(@libui, @red, @green, @blue, @alpha)
            {
              r: @red[0, 8].unpack1('d') * 255.0,
              g: @green[0, 8].unpack1('d') * 255.0,
              b: @blue[0, 8].unpack1('d') * 255.0,
              a: @alpha[0, 8].unpack1('d')
            }
          else
            current_color = color
            value = Glimmer::LibUI.interpret_color(value)
            value[:r] ||= current_color[:r]
            value[:g] ||= current_color[:g]
            value[:b] ||= current_color[:b]
            value[:a] ||= current_color[:a]
            ::LibUI.color_button_set_color(@libui, value[:r].to_f / 255.0, value[:g].to_f / 255.0, value[:b].to_f / 255.0, value[:a])
          end
        end
        
        def red(value = nil)
          if value.nil?
            color[:r]
          else
            self.color = {r: value}
          end
        end
        alias red= red
        alias set_red red
        alias r red
        alias r= red
        alias set_r red
        
        def green(value = nil)
          if value.nil?
            color[:g]
          else
            self.color = {g: value}
          end
        end
        alias green= green
        alias set_green green
        alias g green
        alias g= green
        alias set_g green
        
        def blue(value = nil)
          if value.nil?
            color[:b]
          else
            self.color = {b: value}
          end
        end
        alias blue= blue
        alias set_blue blue
        alias b blue
        alias b= blue
        alias set_b blue
        
        def alpha(value = nil)
          if value.nil?
            color[:a]
          else
            self.color = {a: value}
          end
        end
        alias alpha= alpha
        alias set_alpha alpha
        alias a alpha
        alias a= alpha
        alias set_a alpha
        
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
end
