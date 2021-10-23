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
        def exists?(keyword)
          ::LibUI.respond_to?("new_#{keyword}") ||
            ::LibUI.respond_to?(keyword) ||
            descendant_keyword_constant_map.keys.include?(keyword)
        end
        
        def create(keyword, parent, args, &block)
          widget_proxy_class(keyword).new(keyword, parent, args, &block).tap {|c| control_proxies << c}
        end
        
        def widget_proxy_class(keyword)
          descendant_keyword_constant_map[keyword] || ControlProxy
        end
        
        # autosave all controls in this array to avoid garbage collection
        def control_proxies
          @@control_proxies = [] unless defined?(@@control_proxies)
          @@control_proxies
        end
        
        def main_window_proxy
          control_proxies.find {|c| c.is_a?(WindowProxy)}
        end
        
        def menu_proxies
          control_proxies.select {|c| c.keyword == 'menu' }
        end
        
        def image_proxies
          control_proxies.select {|c| c.keyword == 'image' }
        end
        
        def new_control(keyword, args)
          ::LibUI.send("new_#{keyword}", *args)
        end
        
        def constant_symbol(keyword)
          "#{keyword.camelcase(:upper)}Proxy".to_sym
        end
        
        def keyword(constant_symbol)
          constant_symbol.to_s.underscore.sub(/_proxy$/, '')
        end
        
        def descendant_keyword_constant_map
          @descendant_keyword_constant_map ||= add_aliases_to_keyword_constant_map(map_descendant_keyword_constants_for(self))
        end
        
        def reset_descendant_keyword_constant_map
          @descendant_keyword_constant_map = nil
          descendant_keyword_constant_map
        end
        
        def map_descendant_keyword_constants_for(klass, accumulator: {})
          klass.constants.map do |constant_symbol|
            [constant_symbol, klass.const_get(constant_symbol)]
          end.select do |constant_symbol, constant|
            constant.is_a?(Module) && !accumulator.values.include?(constant)
          end.each do |constant_symbol, constant|
            accumulator[keyword(constant_symbol)] = constant
            map_descendant_keyword_constants_for(constant, accumulator: accumulator)
          end
          accumulator
        end
        
        private
        
        def add_aliases_to_keyword_constant_map(keyword_constant_map)
          KEYWORD_ALIASES.each do |keyword, alias_keyword|
            keyword_constant_map[alias_keyword] = keyword_constant_map[keyword]
          end
          keyword_constant_map
        end
      end
      
      KEYWORD_ALIASES = {
        'msg_box'       => 'message_box',
        'msg_box_error' => 'message_box_error',
      }
      
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
      attr_reader :parent_proxy, :libui, :args, :keyword, :block
      
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
          ::LibUI.respond_to?("control_#{listener_name}") ||
          has_custom_listener?(listener_name)
      end
      
      def handle_listener(listener_name, &listener)
        safe_listener = Proc.new { listener.call(self) }
        if ::LibUI.respond_to?("#{libui_api_keyword}_#{listener_name}")
          ::LibUI.send("#{libui_api_keyword}_#{listener_name}", @libui, &safe_listener)
        elsif ::LibUI.respond_to?("control_#{listener_name}")
          ::LibUI.send("control_#{listener_name}", @libui, &safe_listener)
        elsif has_custom_listener?(listener_name)
          handle_custom_listener(listener_name, &listener)
        end
      end
      
      def has_custom_listener?(listener_name)
        listener_name = listener_name.to_s
        custom_listeners.include?(listener_name) || custom_listener_aliases.stringify_keys.keys.include?(listener_name)
      end
      
      def custom_listeners
        self.class.constants.include?(:LISTENERS) ? self.class::LISTENERS : []
      end
      
      def custom_listener_aliases
        self.class.constants.include?(:LISTENER_ALIASES) ? self.class::LISTENER_ALIASES : {}
      end
      
      def handle_custom_listener(listener_name, &listener)
        listener_name = listener_name.to_s
        listener_name = custom_listener_aliases.stringify_keys[listener_name] || listener_name
        instance_variable_name = "@#{listener_name}_procs"
        instance_variable_set(instance_variable_name, []) if instance_variable_get(instance_variable_name).nil?
        if listener.nil?
          instance_variable_get(instance_variable_name)
        else
          instance_variable_get(instance_variable_name) << listener
          listener
        end
      end
      
      def respond_to?(method_name, *args, &block)
        respond_to_libui?(method_name, *args, &block) ||
          (
            append_properties.include?(method_name.to_s) ||
            (append_properties.include?(method_name.to_s.sub(/\?$/, '')) && BOOLEAN_PROPERTIES.include?(method_name.to_s.sub(/\?$/, ''))) ||
            append_properties.include?(method_name.to_s.sub(/=$/, ''))
          ) ||
          can_handle_listener?(method_name.to_s) ||
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
        elsif can_handle_listener?(method_name.to_s)
          handle_listener(method_name.to_s, &block)
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
          args[0] = Glimmer::LibUI.boolean_to_integer(args.first) if BOOLEAN_PROPERTIES.include?(property) && (args.first.is_a?(TrueClass) || args.first.is_a?(FalseClass))
          args[0] = '' if STRING_PROPERTIES.include?(property) && args.first == nil
          if property.to_s == 'checked'
            current_value = Glimmer::LibUI.integer_to_boolean(::LibUI.send("#{libui_api_keyword}_checked", @libui))
            new_value = Glimmer::LibUI.integer_to_boolean(args[0])
            ::LibUI.send("#{libui_api_keyword}_set_#{property}", @libui, *args) if new_value != current_value
          else
            ::LibUI.send("#{libui_api_keyword}_set_#{property}", @libui, *args)
          end
        elsif ::LibUI.respond_to?("#{libui_api_keyword}_#{method_name}") && !args.empty?
          ::LibUI.send("#{libui_api_keyword}_#{method_name}", @libui, *args)
        elsif ::LibUI.respond_to?("control_#{method_name.to_s.sub(/\?$/, '')}") && args.empty?
          property = method_name.to_s.sub(/\?$/, '')
          value = ::LibUI.send("control_#{property}", @libui, *args)
          handle_string_property(property, handle_boolean_property(property, value))
        elsif ::LibUI.respond_to?("control_set_#{method_name.to_s.sub(/=$/, '')}")
          property = method_name.to_s.sub(/=$/, '')
          args[0] = Glimmer::LibUI.boolean_to_integer(args.first) if BOOLEAN_PROPERTIES.include?(property) && (args.first.is_a?(TrueClass) || args.first.is_a?(FalseClass))
          args[0] = '' if STRING_PROPERTIES.include?(property) && args.first == nil
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
          value = Glimmer::LibUI.boolean_to_integer(value) if BOOLEAN_PROPERTIES.include?(property) && (value.is_a?(TrueClass) || value.is_a?(FalseClass))
          @append_property_hash[property] = value
        end
      end
      
      def libui_api_keyword
        @keyword
      end
      
      def destroy
        if parent_proxy.nil?
          default_destroy
        else
          parent_proxy.destroy_child(self)
        end
      end
      
      def destroy_child(child)
        child.default_destroy
      end
      
      def default_destroy
        send_to_libui('destroy')
        ControlProxy.control_proxies.delete(self)
      end
            
      def enabled(value = nil)
        if value.nil?
          @enabled
        elsif value != @enabled
          @enabled = value == 1 || value
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
      
      def content(&block)
        Glimmer::DSL::Engine.add_content(self, Glimmer::DSL::Libui::ControlExpression.new, @keyword, &block)
      end
      
      private
      
      def build_control
        @libui = if ::LibUI.respond_to?("new_#{keyword}")
          ControlProxy.new_control(@keyword, @args)
        elsif ::LibUI.respond_to?(keyword)
          @args[0] = @args.first.libui if @args.first.is_a?(ControlProxy)
          ::LibUI.send(@keyword, *@args)
        end
      end
      
      def handle_boolean_property(property, value)
        BOOLEAN_PROPERTIES.include?(property) ? Glimmer::LibUI.integer_to_boolean(value) : value
      end
      
      def handle_string_property(property, value)
        STRING_PROPERTIES.include?(property) ? value.to_s : value
      end
    end
  end
end

Dir[File.expand_path('./control_proxy/*.rb', __dir__)].each {|f| require f}
