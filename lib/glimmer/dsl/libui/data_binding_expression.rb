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
require 'glimmer/data_binding/model_binding'

module Glimmer
  module DSL
    module Libui
      # Responsible for wiring data-binding
      # Depends on BindExpression
      class DataBindingExpression < Expression
        def can_interpret?(parent, keyword, *args, &block)
          args.size == 1 and
            args[0].is_a?(DataBinding::ModelBinding)
        end
  
        def interpret(parent, keyword, *args, &block)
          model_binding = args[0]
          model_attribute_observer = Glimmer::DataBinding::Observer.proc do
            parent.send("#{keyword}=", model_binding.evaluate_property)
          end
          model_attribute_observer.observe(model_binding)
          model_attribute_observer.call # initial update
        end
      end
    end
  end
end
