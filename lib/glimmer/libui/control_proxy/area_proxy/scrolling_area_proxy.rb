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

require 'glimmer/libui/control_proxy/area_proxy'

module Glimmer
  module LibUI
    class ControlProxy
      class AreaProxy < ControlProxy
        # Proxy for LibUI scrolling area objects
        #
        # Follows the Proxy Design Pattern
        class ScrollingAreaProxy < AreaProxy
          def build_control
            @area_handler = ::LibUI::FFI::AreaHandler.malloc
            @args[0] ||= Glimmer::LibUI::ControlProxy.main_window_proxy.width
            @args[1] ||= Glimmer::LibUI::ControlProxy.main_window_proxy.height
            @libui    = ::LibUI.new_scrolling_area(@area_handler, *@args)
          end
          
          def width(value = nil)
            if value.nil?
              @args[0]
            else
              @args[0] = value
              set_size(width, height)
            end
          end
          alias width= width
          alias set_width width
          
          def height(value = nil)
            if value.nil?
              @args[1]
            else
              @args[1] = value
              set_size(width, height)
            end
          end
          alias height= height
          alias set_height height
          
          def set_size(width, height)
            @args[0] = width
            @args[1] = height
            super(width, height)
          end
          
          def scroll_to(scroll_x, scroll_y, scroll_width = nil, scroll_height = nil)
            scroll_width, scroll_height = Glimmer::LibUI::ControlProxy.main_window_proxy.content_size
            super(scroll_x, scroll_y, scroll_width, scroll_height)
          end
        end
      end
    end
  end
end
