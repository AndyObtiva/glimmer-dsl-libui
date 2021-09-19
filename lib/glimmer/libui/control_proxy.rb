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
    # Proxy for LibUI control objects
    #
    # Follows the Proxy Design Pattern
    class ControlProxy
      class << self
        def control_exists?(keyword)
          ::LibUI.respond_to?("new_#{keyword}") ||
            ::LibUI.respond_to?(keyword) ||
            Glimmer::LibUI.constants.include?("#{keyword.camelcase(:upper)}Proxy".to_sym)
        end
        
        def create(keyword, parent, args, &block)
          widget_proxy_class(keyword).new(keyword, parent, args, &block).tap {|c| all_control_proxies << c}
        end
        
        def widget_proxy_class(keyword)
          begin
            class_name = "#{keyword.camelcase(:upper)}Proxy".to_sym
            Glimmer::LibUI.const_get(class_name)
          rescue
            Glimmer::LibUI::ControlProxy
          end
        end
        
        # autosave all controls in this array to avoid garbage collection
        def all_control_proxies
          @@all_control_proxies = [] unless defined?(@@all_control_proxies)
          @@all_control_proxies
        end
        
        def main_window_proxy
          all_control_proxies.find {|c| c.is_a?(WindowProxy)}
        end
        
        def integer_to_boolean(int)
          int.nil? ? nil : int == 1
        end
        
        def boolean_to_integer(bool)
          bool.nil? ? nil : (bool ? 1 : 0)
        end
      end
      
      BOOLEAN_PROPERTIES = %w[
        padded
        checked
        enabled toplevel visible
        read_only
        margined
        borderless fullscreen
        stretchy
      ]
      
      STRING_PROPERTIES = %w[
        text
        title
      ]
      
      # libui returns the contained LibUI object
      attr_reader :parent_proxy, :libui, :args, :keyword
      
      def initialize(keyword, parent, args, &block)
        @keyword = keyword
        @parent_proxy = parent
        @args = args
        @block = block
        @enabled = true
        build_control
        post_add_content if @block.nil?
      end
      
      # Subclasses may override to perform post add_content work (normally must call super)
      def post_add_content
        @parent_proxy&.post_initialize_child(self)
      end
      
      # Subclasses may override to perform post initialization work on an added child
      def post_initialize_child(child)
        # No Op by default
      end
      
      def window_proxy
        found_proxy = self
        until found_proxy.nil? || found_proxy.is_a?(WindowProxy)
          found_proxy = found_proxy.parent_proxy
        end
        found_proxy
      end

      def can_handle_listener?(listener_name)
        ::LibUI.respond_to?("#{libui_api_keyword}_#{listener_name}") ||
          ::LibUI.respond_to?("control_#{listener_name}")
      end
      
      def handle_listener(listener_name, &listener)
        safe_listener = Proc.new { listener.call(self) }
        if ::LibUI.respond_to?("#{libui_api_keyword}_#{listener_name}")
          ::LibUI.send("#{libui_api_keyword}_#{listener_name}", @libui, &safe_listener)
        elsif ::LibUI.respond_to?("control_#{listener_name}")
          ::LibUI.send("control_#{listener_name}", @libui, &safe_listener)
        end
      end
      
      def respond_to?(method_name, *args, &block)
        respond_to_libui?(method_name, *args, &block) ||
          (
            append_properties.include?(method_name.to_s) ||
            (append_properties.include?(method_name.to_s.sub(/\?$/, '')) && BOOLEAN_PROPERTIES.include?(method_name.to_s.sub(/\?$/, ''))) ||
            append_properties.include?(method_name.to_s.sub(/=$/, ''))
          ) ||
          super(method_name, true)
      end
      
      def respond_to_libui?(method_name, *args, &block)
        ::LibUI.respond_to?("control_#{method_name}") ||
          (::LibUI.respond_to?("control_#{method_name.to_s.sub(/\?$/, '')}") && BOOLEAN_PROPERTIES.include?(method_name.to_s.sub(/\?$/, '')) ) ||
          ::LibUI.respond_to?("control_set_#{method_name.to_s.sub(/=$/, '')}") ||
          ::LibUI.respond_to?("#{libui_api_keyword}_#{method_name}") ||
          (::LibUI.respond_to?("#{libui_api_keyword}_#{method_name.to_s.sub(/\?$/, '')}") && BOOLEAN_PROPERTIES.include?(method_name.to_s.sub(/\?$/, '')) ) ||
          ::LibUI.respond_to?("#{libui_api_keyword}_set_#{method_name.to_s.sub(/=$/, '')}")
      end
      
      def method_missing(method_name, *args, &block)
        if respond_to_libui?(method_name, *args, &block)
          send_to_libui(method_name, *args, &block)
        elsif append_properties.include?(method_name.to_s) ||
            append_properties.include?(method_name.to_s.sub(/(=|\?)$/, ''))
          append_property(method_name, *args)
        else
          super
        end
      end
      
      def send_to_libui(method_name, *args, &block)
        if ::LibUI.respond_to?("#{libui_api_keyword}_#{method_name.to_s.sub(/\?$/, '')}") && args.empty?
          property = method_name.to_s.sub(/\?$/, '')
          value = ::LibUI.send("#{libui_api_keyword}_#{property}", @libui, *args)
          handle_string_property(property, handle_boolean_property(property, value))
        elsif ::LibUI.respond_to?("#{libui_api_keyword}_set_#{method_name.to_s.sub(/=$/, '')}") && !args.empty?
          property = method_name.to_s.sub(/=$/, '')
          args[0] = ControlProxy.boolean_to_integer(args.first) if BOOLEAN_PROPERTIES.include?(property) && (args.first.is_a?(TrueClass) || args.first.is_a?(FalseClass))
          ::LibUI.send("#{libui_api_keyword}_set_#{property}", @libui, *args)
        elsif ::LibUI.respond_to?("#{libui_api_keyword}_#{method_name}") && !args.empty?
          ::LibUI.send("#{libui_api_keyword}_#{method_name}", @libui, *args)
        elsif ::LibUI.respond_to?("control_#{method_name.to_s.sub(/\?$/, '')}") && args.empty?
          property = method_name.to_s.sub(/\?$/, '')
          value = ::LibUI.send("control_#{method_name.to_s.sub(/\?$/, '')}", @libui, *args)
          handle_string_property(property, handle_boolean_property(property, value))
        elsif ::LibUI.respond_to?("control_set_#{method_name.to_s.sub(/=$/, '')}")
          property = method_name.to_s.sub(/=$/, '')
          args[0] = ControlProxy.boolean_to_integer(args.first) if BOOLEAN_PROPERTIES.include?(property) && (args.first.is_a?(TrueClass) || args.first.is_a?(FalseClass))
          ::LibUI.send("control_set_#{method_name.to_s.sub(/=$/, '')}", @libui, *args)
        elsif ::LibUI.respond_to?("control_#{method_name}") && !args.empty?
          ::LibUI.send("control_#{method_name}", @libui, *args)
        end
      end
      
      def append_properties
        @parent_proxy&.class&.constants&.include?(:APPEND_PROPERTIES) ? @parent_proxy.class::APPEND_PROPERTIES : []
      end
      
      def append_property(property, value = nil)
        property = property.to_s.sub(/(=|\?)$/, '')
        @append_property_hash ||= {}
        if value.nil?
          value = @append_property_hash[property]
          handle_string_property(property, handle_boolean_property(property, value))
        else
          value = ControlProxy.boolean_to_integer(value) if BOOLEAN_PROPERTIES.include?(property) && (value.is_a?(TrueClass) || value.is_a?(FalseClass))
          @append_property_hash[property] = value
        end
      end
      
      def libui_api_keyword
        @keyword
      end
      
      def enabled(value = nil)
        if value.nil?
          @enabled
        elsif value != @enabled
          if value == 1 || value
            send_to_libui('enable')
          else
            send_to_libui('disable')
          end
        end
      end
      alias enabled? enabled
      alias set_enabled enabled
      alias enabled= enabled
      
      def visible(value = nil)
        current_value = send_to_libui('visible')
        if value.nil?
          current_value
        elsif value != current_value
          if value == 1 || value
            send_to_libui('show')
          else
            send_to_libui('hide')
          end
        end
      end
      alias visible? visible
      alias set_visible visible
      alias visible= visible
      
      def destroy
        send_to_libui('destroy')
        self.class.all_control_proxies.delete(self)
      end
            
      private
      
      def build_control
        @libui = if ::LibUI.respond_to?("new_#{keyword}")
          ::LibUI.send("new_#{@keyword}", *@args)
        elsif ::LibUI.respond_to?(keyword)
          @args[0] = @args.first.libui if @args.first.is_a?(ControlProxy)
          ::LibUI.send(@keyword, *@args)
        end
      end
      
      def handle_boolean_property(property, value)
        BOOLEAN_PROPERTIES.include?(property) ? ControlProxy.integer_to_boolean(value) : value
      end
      
      def handle_string_property(property, value)
        STRING_PROPERTIES.include?(property) ? value.to_s : value
      end
    end
  end
end
