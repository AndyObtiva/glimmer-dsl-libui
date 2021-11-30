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
      # Sets up read/write (bidirectional) data-binding
      #
      # classes are expected to implement `data_bind_write(property, model_binding)` to setup write data-binding
      # by observing view property for changes and writing to model attribute via model binding accordingly
      #
      # classes can override data_bind_read to disable read data-binding in rare scenarios that might need it
      #
      # returns model attribute reading observer by default
      def data_bind(property, model_binding)
        data_bind_read(property, model_binding).tap do
          data_bind_write(property, model_binding) unless model_binding.binding_options[:read_only]
        end
      end
      
      # Sets up read data-binding (reading from model to update view)
      #
      # Default implementation observes model attribute for changes via model binding
      # and updates view property accordingly
      def data_bind_read(property, model_binding)
        model_attribute_observer = Glimmer::DataBinding::Observer.proc do
          new_value = model_binding.evaluate_property
          send("#{property}=", new_value) unless send(property) == new_value
        end
        model_attribute_observer.observe(model_binding)
        model_attribute_observer.call # initial update
        model_attribute_observer
      end
      
      # Sets up write data-binding (writing to model from view)
      #
      # Has no implementation by default. Classes are expected
      # to implement this method by observing view property
      # for changes and writing them to model accordingly via model binding
      def data_bind_write(property, model_binding)
        # No Op by default
      end
    end
  end
end
