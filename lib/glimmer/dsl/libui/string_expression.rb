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

require 'glimmer/dsl/parent_expression'

module Glimmer
  module DSL
    module Libui
      class StringExpression < Expression
        include ParentExpression
        
        def can_interpret?(parent, keyword, *args, &block)
          keyword == 'string' and
            (
              (require('glimmer/libui/control_proxy/text_proxy'); parent.is_a?(Glimmer::LibUI::ControlProxy::TextProxy)) or
              ((require('glimmer/libui/attributed_string'); parent.is_a?(Glimmer::LibUI::AttributedString)) and !args.empty?)
            )
        end
  
        def interpret(parent, keyword, *args, &block)
          require('glimmer/libui/control_proxy/text_proxy')
          if parent.is_a?(Glimmer::LibUI::ControlProxy::TextProxy)
            require('glimmer/libui/attributed_string')
            Glimmer::LibUI::AttributedString.new(keyword, parent, args, &block)
          else
            parent.string = args.join
          end
        end
        
        def add_content(parent, keyword, *args, &block)
          options = args.last.is_a?(Hash) ? args.last : {}
          options[:post_add_content] = true if !options.include?(:post_add_content)
          parent&.post_add_content(block) if options[:post_add_content]
        end
      end
    end
  end
end
