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

require 'glimmer/libui/parent'

module Glimmer
  module LibUI
    # Represents LibUI lightweight shape objects nested under path (e.g. line, rectangle, arc, bezier)
    class Shape
      class << self
        def exists?(keyword)
          Glimmer::LibUI.constants.include?(constant_symbol(keyword)) and
            shape_class(keyword).respond_to?(:ancestors) and
            shape_class(keyword).ancestors.include?(Shape)
        end
        
        def create(keyword, parent, args, &block)
          shape_class(keyword).new(keyword, parent, args, &block)
        end
        
        def shape_class(keyword)
          Glimmer::LibUI.const_get(constant_symbol(keyword))
        end
        
        def parameters(*params)
          if params.empty?
            @parameters
          else
            @parameters = params
          end
        end
        
        def parameter_defaults(*defaults)
          if defaults.empty?
            @parameter_defaults
          else
            @parameter_defaults = defaults
          end
        end
        
        private
        
        def constant_symbol(keyword)
          "#{keyword.camelcase(:upper)}".to_sym
        end
      end
      
      include Parent
      
      attr_reader :parent, :args, :keyword, :block
      
      def initialize(keyword, parent, args, &block)
        @keyword = keyword
        @parent = parent
        @args = args
        @block = block
        set_parameter_defaults
        post_add_content if @block.nil?
      end
      
      # Subclasses may override to perform post add_content work (normally must call super)
      def post_add_content
        @parent&.post_initialize_child(self)
      end
      
      # Subclasses must override to perform draw work and call super afterwards to ensure calling destroy when semi-declarative in an on_draw method
      def draw(area_draw_params)
        destroy if area_proxy.nil?
      end
      
      def redraw
        area_proxy&.queue_redraw_all
      end
      
      def destroy
        @parent.children.delete(self)
      end
      
      def area_proxy
        find_parent_in_ancestors { |parent| parent.nil? || parent.is_a?(AreaProxy) }
      end
      
      def path_proxy
        find_parent_in_ancestors { |parent| parent.nil? || parent.is_a?(PathProxy) }
      end
      
      def respond_to?(method_name, *args, &block)
        self.class.parameters.include?(method_name.to_s.sub(/=$/, '').sub(/^set_/, '').to_sym) or
          super(method_name, true)
      end
      
      def method_missing(method_name, *args, &block)
        method_name_parameter = method_name.to_s.sub(/=$/, '').sub(/^set_/, '').to_sym
        if self.class.parameters.include?(method_name_parameter)
          method_name = method_name.to_s
          parameter_index = self.class.parameters.index(method_name_parameter)
          if method_name.start_with?('set_') || method_name.end_with?('=') || !args.empty?
            @args[parameter_index] = args.first
            area_proxy&.queue_redraw_all
          else
            @args[parameter_index]
          end
        else
          super
        end
      end
      
      private
      
      def set_parameter_defaults
        self.class.parameter_defaults.each_with_index do |default, i|
          @args[i] ||= default
        end
      end
      
      def find_parent_in_ancestors(&condition)
        found = self
        until condition.call(found)
          found = found.respond_to?(:parent_proxy) ? found.parent_proxy : found.parent
        end
        found
      end
    end
  end
end
