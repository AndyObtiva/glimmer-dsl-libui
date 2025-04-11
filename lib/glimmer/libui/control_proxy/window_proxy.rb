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

require 'glimmer/libui/control_proxy'
require 'glimmer/libui/control_proxy/area_proxy'

module Glimmer
  module LibUI
    class ControlProxy
      # Proxy for LibUI window objects
      #
      # Follows the Proxy Design Pattern
      class WindowProxy < ControlProxy
        CUSTOM_LISTENER_NAMES = ['on_destroy']
        CUSTOM_LISTENER_NAME_ALIASES = {
          on_destroyed: 'on_destroy',
        }
        DEFAULT_TITLE = ''
        DEFAULT_WIDTH = 190
        DEFAULT_HEIGHT = 150
        DEFAULT_HAS_MENUBAR = 1
        
        def post_initialize_child(child)
          ::LibUI.window_set_child(@libui, child.libui)
        end
        
        def destroy_child(child)
          ::LibUI.send("window_set_child", @libui, nil)
          super
        end
        
        def destroy
          return if @destroying
          @destroying = true
          @on_closing_listeners&.clear
          super
          ControlProxy.image_proxies.each { |image_proxy| ::LibUI.free_image(image_proxy.libui) unless image_proxy.area_image? }
          notify_custom_listeners('on_destroy', self)
          deregister_custom_listeners('on_destroy')
          @destroying = false
        end
        
        def destroying?
          @destroying
        end
        
        def show
          super
          unless @shown_at_least_once
            @shown_at_least_once = true
            ::LibUI.main
            ::LibUI.quit
          end
        end
        alias open show
        
        def handle_listener(listener_name, &listener)
          case listener_name
          when 'on_closing'
            @on_closing_listeners ||= []
            @on_closing_listeners << listener
            @default_behavior_listener ||= Proc.new do
              return_value = nil
              @on_closing_listeners.each do |l|
                return_value = l.call(self)
                break if return_value.is_a?(Numeric) || return_value.is_a?(TrueClass) || return_value.is_a?(FalseClass)
              end
              if return_value.is_a?(Numeric)
                return_value
              elsif return_value.is_a?(TrueClass) || return_value.is_a?(FalseClass)
                return_value ? 1 : 0
              elsif self != ControlProxy.main_window_proxy
                1
              else
                destroy
                ::LibUI.quit
                0
              end
            end.tap do |default_behavior_listener|
              super(listener_name, &default_behavior_listener)
            end
          else
            super
          end
        end
        
        def content_size(*args)
          if args.empty?
            width = Fiddle::Pointer.malloc(64)
            height = Fiddle::Pointer.malloc(64)
            ::LibUI.window_content_size(@libui, width, height)
            width = width[0, 64].unpack1('i')
            height = height[0, 64].unpack1('i')
            [width, height]
          else
            args = args.first if args.size == 1 && args.first.is_a?(Array)
            super
            @width = args[0]
            @height = args[1]
          end
        end
        alias content_size= content_size
        alias set_content_size content_size
        
        def width(value = nil)
          if value.nil?
            content_size.first
          else
            set_content_size(value, height)
          end
        end
        alias width= width
        alias set_width width
        
        def height(value = nil)
          if value.nil?
            content_size.last
          else
            set_content_size(width, value)
          end
        end
        alias height= height
        alias set_height height
        
        def resizable(value = nil)
          if value.nil?
            @resizable = true if @resizable.nil?
            @resizable
          else
            @resizable = value
            if !@resizable && !@resizable_listener_registered
              handle_listener('on_content_size_changed') do
                set_content_size(@width, @height) unless @resizable
              end
              @resizable_listener_registered = true
            end
          end
        end
        alias resizable? resizable
        alias resizable= resizable
        alias set_resizable resizable
        
        def focused
          Glimmer::LibUI.integer_to_boolean(super)
        end
        alias focused? focused
      
        private
        
        def build_control
          if OS.mac? && ControlProxy.menu_proxies.empty?
            menu_proxy = ControlProxy.create('menu', nil, [''])
            quit_menu_item_proxy = ControlProxy.create('quit_menu_item', menu_proxy, [])
          end
          construction_args = @args.dup
          construction_args[0] = DEFAULT_TITLE if construction_args.size == 0
          construction_args[1] = DEFAULT_WIDTH if construction_args.size == 1
          construction_args[2] = DEFAULT_HEIGHT if construction_args.size == 2
          construction_args[3] = DEFAULT_HAS_MENUBAR if construction_args.size == 3
          construction_args[3] = Glimmer::LibUI.boolean_to_integer(construction_args[3]) if construction_args.size == 4 && (construction_args[3].is_a?(TrueClass) || construction_args[3].is_a?(FalseClass))
          @width = construction_args[1]
          @height = construction_args[2]
          @libui = ControlProxy.new_control(@keyword, construction_args)
          @libui.tap do
            # setup default on_closing listener if no on_closing listeners are setup
            handle_listener('on_closing') {} if @on_closing_listeners.nil? || @on_closing_listeners.empty?
          end
        end
      end
    end
  end
end
