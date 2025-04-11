# Copyright (c) 2021-2025 Andy Maleh
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
require 'glimmer'
require 'glimmer/error'
require 'glimmer/proc_tracker'
require 'glimmer/data_binding/observer'
require 'glimmer/data_binding/observable_model'

module Glimmer
  module LibUI
    module CustomControl
      include SuperModule
      include DataBinding::ObservableModel
      
      # This module was only created to prevent Glimmer from checking method_missing first
      module GlimmerSupersedable
        def method_missing(method_name, *args, &block)
          # TODO Consider supporting a glimmer error silencing option for methods defined here
          # but fail the glimmer DSL for the right reason to avoid seeing noise in the log output
          if block && can_handle_listener?(method_name)
            handle_listener(method_name, &block)
          elsif @body_root.respond_to?(method_name, true)
            @body_root.send(method_name, *args, &block)
          else
            super
          end
        end
      
        def respond_to?(method_name, *args, &block)
          result = false
          result ||= super
          result ||= can_handle_listener?(method_name)
          result ||= @body_root.respond_to?(method_name, *args, &block)
        end
      end
      
      super_module_included do |klass|
        # TODO clear memoization of ControlProxy.libui_class_for for a keyword if a custom control was defined with that keyword
        unless klass.name.include?('Glimmer::LibUI::CustomWindow')
          klass.include(Glimmer)
          klass.include(GlimmerSupersedable) # prevent Glimmer from running method_missing first
          Glimmer::LibUI::CustomControl.add_custom_control_namespaces_for(klass)
        end
      end
    
      class << self
        def for(keyword)
          unless flyweight_custom_control_classes.keys.include?(keyword)
            begin
              extracted_namespaces = keyword.
                to_s.
                split(/__/).map do |namespace|
                  namespace.camelcase(:upper)
                end
              custom_control_namespaces.each do |base|
                extracted_namespaces.reduce(base) do |result, namespace|
                  if !result.constants.include?(namespace)
                    namespace = result.constants.detect {|c| c.to_s.upcase == namespace.to_s.upcase } || namespace
                  end
                  begin
                    flyweight_custom_control_classes[keyword] = constant = result.const_get(namespace)
                    return constant if constant.ancestors.include?(Glimmer::LibUI::CustomControl)
                    flyweight_custom_control_classes[keyword] = constant
                  rescue => e
                    # Glimmer::Config.logger.debug {"#{e.message}\n#{e.backtrace.join("\n")}"}
                    flyweight_custom_control_classes[keyword] = result
                  end
                end
              end
              raise "#{keyword} has no custom control class!"
            rescue => e
              Glimmer::Config.logger.debug {e.message}
              Glimmer::Config.logger.debug {"#{e.message}\n#{e.backtrace.join("\n")}"}
              flyweight_custom_control_classes[keyword] = nil
            end
          end
          flyweight_custom_control_classes[keyword]
        end
        
        # Flyweight Design Pattern memoization cache. Can be cleared if memory is needed.
        def flyweight_custom_control_classes
          @flyweight_custom_control_classes ||= {}
        end
        
        # Returns keyword to use for this custom control
        def keyword
          self.name.underscore.gsub('::', '__')
        end
        
        # Returns shortcut keyword to use for this custom control (keyword minus namespace)
        def shortcut_keyword
          self.name.underscore.gsub('::', '__').split('__').last
        end
        
        def add_custom_control_namespaces_for(klass)
          Glimmer::LibUI::CustomControl.namespaces_for_class(klass).drop(1).each do |namespace|
            Glimmer::LibUI::CustomControl.custom_control_namespaces << namespace
          end
        end

        def namespaces_for_class(m)
          return [m] if m.name.nil?
          namespace_constants = m.name.split(/::/).map(&:to_sym)
          namespace_constants.reduce([Object]) do |output, namespace_constant|
            output += [output.last.const_get(namespace_constant)]
          end[1..-1].uniq.reverse
        end

        def custom_control_namespaces
          @custom_control_namespaces ||= reset_custom_control_namespaces
        end

        def reset_custom_control_namespaces
          @custom_control_namespaces = Set[Object, Glimmer::LibUI]
        end

        # Allows defining convenience option accessors for an array of option names
        # Example: `options :color1, :color2` defines `#color1` and `#color2`
        # where they return the instance values `options[:color1]` and `options[:color2]`
        # respectively.
        # Can be called multiple times to set more options additively.
        # When passed no arguments, it returns list of all option names captured so far
        def options(*new_options)
          new_options = new_options.compact.map(&:to_s).map(&:to_sym)
          if new_options.empty?
            @options ||= {} # maps options to defaults
          else
            new_options = new_options.reduce({}) {|new_options_hash, new_option| new_options_hash.merge(new_option => nil)}
            @options = options.merge(new_options)
            def_option_attr_accessors(new_options)
          end
        end

        def option(new_option, default: nil)
          new_option = new_option.to_s.to_sym
          new_options = {new_option => default}
          @options = options.merge(new_options)
          def_option_attr_accessors(new_options)
        end

        def def_option_attr_accessors(new_options)
          new_options.each do |option, default|
            class_eval <<-end_eval, __FILE__, __LINE__
              def #{option}
                options[:#{option}]
              end
              
              def #{option}=(option_value)
                self.options[:#{option}] = option_value
              end
            end_eval
          end
        end
        
        def before_body(&block)
          @before_body_block = block
        end

        def body(&block)
          @body_block = block
        end

        def after_body(&block)
          @after_body_block = block
        end
        
        def custom_controls_being_interpreted
          @custom_controls_being_interpreted ||= []
        end
      end

      attr_reader :body_root, :libui, :parent, :parent_proxy, :args, :keyword, :content, :options, :slot_controls

      def initialize(keyword, parent, args, options, &content)
        CustomControl.custom_controls_being_interpreted << self
        @parent_proxy = @parent = parent
        options ||= {}
        @options = self.class.options.merge(options)
        @slot_controls = {}
        @content = ProcTracker.new(content) if content
        execute_hook('before_body')
        body_block = self.class.instance_variable_get("@body_block")
        raise Glimmer::Error, 'Invalid custom control for having no body! Please define body block!' if body_block.nil?
        @body_root = instance_exec(&body_block)
        raise Glimmer::Error, 'Invalid custom control for having an empty body! Please fill body block!' if @body_root.nil?
        @libui = @body_root.libui
        execute_hook('after_body')
        # TODO deregister all observer_registrations on destroy of the control once that listener is supported
        # (on_destroy) unless it is the last window closing, in which case exit faster
        post_add_content if content.nil?
      end
      
      # Subclasses may override to perform post initialization work on an added child
      def post_initialize_child(child)
        # No Op by default
      end

      def post_add_content
        @parent_proxy&.post_initialize_child(@body_root)
        Glimmer::LibUI::CustomControl.custom_controls_being_interpreted.pop
      end
      
      def observer_registrations
        @observer_registrations ||= []
      end

      def can_handle_listener?(listener)
        body_root&.can_handle_listener?(listener.to_s)
      end

      def handle_listener(listener, &block)
        body_root.handle_listener(listener.to_s, &block)
      end
      
      # This method ensures it has an instance method not coming from Glimmer DSL
      def has_instance_method?(method_name)
        respond_to?(method_name) and
          !@body_root.respond_to_libui?(method_name) and
          (method(method_name) rescue nil) and
          !method(method_name)&.source_location&.first&.include?('glimmer/dsl/engine.rb') and
          !method(method_name)&.source_location&.first&.include?('glimmer/libui/control_proxy.rb')
      end

      # Returns content block if used as an attribute reader (no args)
      # Otherwise, if a block is passed, it adds it as content to this custom control
      def content(*args, &block)
        if args.empty?
          if block_given?
            Glimmer::DSL::Engine.add_content(self, Glimmer::DSL::Libui::CustomControlExpression.new, self.class.keyword, &block)
          else
            @content
          end
        else
          # delegate to GUI DSL ContentExpression
          super
        end
      end
      
      private

      def execute_hook(hook_name)
        hook_block = self.class.instance_variable_get("@#{hook_name}_block")
        return if hook_block.nil?
        temp_method_name = "#{hook_name}_block_#{hook_block.hash.abs}_#{(Time.now.to_f * 1_000_000).to_i}"
        singleton_class.define_method(temp_method_name, &hook_block)
        send(temp_method_name)
        singleton_class.send(:remove_method, temp_method_name)
      end
    end
  end
end

Dir[File.expand_path("./#{File.basename(__FILE__, '.rb')}/*.rb", __dir__)].each {|f| require f}
