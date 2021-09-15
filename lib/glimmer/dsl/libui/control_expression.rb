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

require 'glimmer/dsl/expression'
require 'glimmer/dsl/parent_expression'

module Glimmer
  module DSL
    module Libui
      class ControlExpression < Expression
        include ParentExpression
  
        def can_interpret?(parent, keyword, *args, &block)
          Glimmer::LibUI::ControlProxy.control_exists?(keyword)
        end
  
        def interpret(parent, keyword, *args, &block)
          Glimmer::LibUI::ControlProxy.create(keyword, parent, args, &block)
        end
        
        def add_content(parent, keyword, *args, &block)
          super
          parent.post_add_content
        end
        
      end
    end
  end
end

# TODO Consider moving all controls underneath Control namespace
require 'glimmer/libui/control_proxy'
require 'glimmer/libui/window_proxy'
require 'glimmer/libui/horizontal_box_proxy'
require 'glimmer/libui/vertical_box_proxy'
