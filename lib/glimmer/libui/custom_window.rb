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

require 'super_module'
require 'glimmer/libui/custom_control'
require 'glimmer/error'

module Glimmer
  module LibUI
    module CustomWindow
      include SuperModule
      include Glimmer::LibUI::CustomControl
      
      class << self
        def launch(*args, &content)
          @@launched_custom_window = send(keyword, *args, &content)
          @@launched_custom_window.show
          @@launched_custom_window
        end
        
        def launched_custom_window
          @@launched_custom_window if defined?(@@launched_custom_window)
        end
        
        def launched_application
          launched_custom_window
        end
      end
      
      def initialize(parent, *swt_constants, options, &content)
        original_logger = Glimmer::Config.logger
        require 'stringio'
        Glimmer::Config.logger = Logger.new(StringIO.new)
        super
        Glimmer::Config.logger = original_logger
        raise Glimmer::Error, 'Invalid custom window body root! Must be a window, another custom window, or a custom control with window as its body root!' unless body_root.is_a?(Glimmer::LibUI::ControlProxy::WindowProxy) || body_root.is_a?(Glimmer::LibUI::CustomWindow) || (body_root.is_a?(Glimmer::LibUI::CustomControl) && body_root.body_root.is_a?(Glimmer::LibUI::ControlProxy::WindowProxy))
      end
      
      # Classes may override
      def show
        body_root.show
      end

      # TODO consider using Forwardable instead
      def destroy
        body_root.destroy
      end

      def destroying?
        body_root.destroying?
      end
    end
    
    Application = CustomWindow
  end
end
