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
require 'glimmer/libui/control_proxy/box/horizontal_box_proxy'

module Glimmer
  module LibUI
    class ControlProxy
      # Proxy for LibUI tab item objects
      #
      # Follows the Proxy Design Pattern
      class TabItemProxy < ControlProxy
        attr_reader :index, :root_proxy
        
        def initialize(keyword, parent, args, &block)
          @keyword = keyword
          @parent_proxy = parent
          @root_proxy = nil
          @args = args
          @block = block
          @enabled = 1
          @index = @parent_proxy.num_pages
          build_control
          @content = @root_proxy.content(&@block) if @block
        end
        
        def name
          @args.first
        end
        
        def margined(value = nil)
          if value.nil?
            @parent_proxy.margined(@index)
          else
            @parent_proxy.margined(@index, value)
          end
        end
        alias set_margined margined
        alias margined= margined
        alias margined? margined
            
        # TODO implement tab_insert_at
        
        def destroy
          @parent_proxy.delete(@index)
        end
            
        private
        
        def build_control
          @root_proxy = Box::VerticalBoxProxy.new('vertical_box', @parent_proxy, [])
          # TODO support being able to re-open a tab item and add content.. it needs special code.. perhaps by having a @content parent for every tab item, this problem becomes easier to solve
          @parent_proxy.append(name, @root_proxy.libui) # returns nil, so there is no @libui object to store in this case
        end
      end
    end
  end
end
