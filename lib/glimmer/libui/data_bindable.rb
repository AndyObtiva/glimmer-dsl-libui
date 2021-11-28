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

module Glimmer
  module LibUI
    # Parent controls and shapes who have children and add child post_initialize_child
    module DataBindable
      # Data-binds model to update view.
      # Subclasses can override to do inverse data-binding by observing view control for property changes and updating model binding accordingly
      def data_bind(property, model_binding)
        model_attribute_observer = Glimmer::DataBinding::Observer.proc do
          new_value = model_binding.evaluate_property
          send("#{property}=", new_value) unless send(property) == new_value
        end
        model_attribute_observer.observe(model_binding)
        model_attribute_observer.call # initial update
        model_attribute_observer
      end
    end
  end
end
