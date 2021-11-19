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
require 'glimmer/libui/control_proxy/area_proxy'
require 'glimmer/libui/control_proxy/path_proxy'

module Glimmer
  module LibUI
    # Represents LibUI lightweight shape objects nested under path (e.g. line, rectangle, arc, bezier)
    class Shape
      class << self
        def exists?(keyword)
          Shape.constants.include?(constant_symbol(keyword)) and
            shape_class(keyword).respond_to?(:ancestors) and
            shape_class(keyword).ancestors.include?(Shape)
        end
        
        def create(keyword, parent, args, &block)
          shape_class(keyword).new(keyword, parent, args, &block)
        end
        
        def shape_class(keyword)
          Shape.const_get(constant_symbol(keyword))
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
        build_control if implicit_path?
        post_add_content if @block.nil?
      end
      
      # Subclasses may override to perform post add_content work (normally must call super)
      def post_add_content
        @parent&.post_initialize_child(self)
        @parent.post_add_content if implicit_path? && dynamic?
      end
      
      # Subclasses must override to perform draw work and call super afterwards to ensure calling destroy when semi-declarative in an on_draw method
      def draw(area_draw_params)
        destroy if area_proxy.nil?
      end
      
      def redraw
        area_proxy&.auto_redraw
      end
      
      def request_auto_redraw
        area_proxy&.request_auto_redraw
      end
      
      def destroy
        @parent.children.delete(self)
      end
      
      def area_proxy
        find_parent_in_ancestors { |parent| parent.nil? || parent.is_a?(ControlProxy::AreaProxy) }
      end
      
      def path_proxy
        find_parent_in_ancestors { |parent| parent.nil? || parent.is_a?(ControlProxy::PathProxy) }
      end
    
      def fill(*args)
        path_proxy.fill(*args)
      end
      alias fill= fill
      alias set_fill fill
      
      def stroke(*args)
        path_proxy.stroke(*args)
      end
      alias stroke= stroke
      alias set_stroke stroke
      
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
            if args.first != @args[parameter_index]
              @args[parameter_index] = args.first
              request_auto_redraw
            end
          else
            @args[parameter_index]
          end
        else # TODO consider if there is a need to redirect anything to path proxy or delete this TODO
          super
        end
      end
      
      private
      
      def build_control
        block = Proc.new {} if dynamic?
        @parent = Glimmer::LibUI::ControlProxy::PathProxy.new('path', @parent, [], &block)
      end
      
      # indicates if nested directly under area or on_draw event (having an implicit path not an explicit path parent)
      def implicit_path?
        @implicit_path ||= !!(@parent.is_a?(Glimmer::LibUI::ControlProxy::AreaProxy) || (@parent.nil? && Glimmer::LibUI::ControlProxy::AreaProxy.current_area_draw_params))
      end
      
      def dynamic?
        ((@parent.nil? || (@parent.is_a?(ControlProxy::PathProxy) && @parent.parent_proxy.nil?)) && Glimmer::LibUI::ControlProxy::AreaProxy.current_area_draw_params)
      end
      
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

Dir[File.expand_path("./#{File.basename(__FILE__, '.rb')}/*.rb", __dir__)].each {|f| require f}
