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

require 'glimmer'
require 'glimmer/dsl/expression'
require 'glimmer/dsl/parent_expression'
require 'glimmer/dsl/top_level_expression'
require 'glimmer/libui/custom_control'
require 'glimmer/libui/custom_window'

module Glimmer
  module DSL
    module Libui
      class CustomControlExpression < Expression
        # TODO Consider making custom controls automatically generate static expressions
        include ParentExpression
        include TopLevelExpression

        def can_interpret?(parent, keyword, *args, &block)
          LibUI::CustomControl.for(keyword)
        end
  
        def interpret(parent, keyword, *args, &block)
          options = args.last.is_a?(Hash) ? args.pop : {}
          LibUI::CustomControl.for(keyword).new(keyword, parent, args, options, &block)
        end
  
        def add_content(custom_control, keyword, *args, &block)
          options = args.last.is_a?(Hash) ? args.last : {}
          options[:post_add_content] = true if !options.include?(:post_add_content)
          # TODO consider avoiding source_location
          if block.source_location == custom_control.content&.__getobj__&.source_location
            custom_control.content.call(custom_control) unless custom_control.content.called?
          else
            super
          end
          custom_control.post_add_content if options[:post_add_content]
        end
      end
    end
  end
end
