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

require 'glimmer/libui/control_proxy'
require 'glimmer/libui/control_proxy/area_proxy'

module Glimmer
  module LibUI
    class ControlProxy
      # Proxy for LibUI window objects
      #
      # Follows the Proxy Design Pattern
      class WindowProxy < ControlProxy
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
          super
          ControlProxy.image_proxies.each { |image_proxy| ::LibUI.free_image(image_proxy.libui) }
          @on_destroy_procs&.each { |on_destroy_proc| on_destroy_proc.call(self)}
        end
        
        def on_destroy(&block)
          # TODO look into a way to generalize this logic for multiple listeners
          @on_destroy_procs ||= []
          if block.nil?
            @on_destroy_procs
          else
            @on_destroy_procs << block
            block
          end
        end
      
        def show
          super
          unless @shown_at_least_once
            @shown_at_least_once = true
            ::LibUI.main
            ::LibUI.quit
          end
        end
        
        def can_handle_listener?(listener_name)
          listener_name == 'on_destroy' || super
        end
        
        def handle_listener(listener_name, &listener)
          case listener_name
          when 'on_destroy'
            on_destroy(&listener)
          else
            default_behavior_listener = nil
            if listener_name == 'on_closing'
              default_behavior_listener = Proc.new do
                return_value = listener.call(self)
                if return_value.is_a?(Numeric)
                  return_value
                else
                  destroy
                  ::LibUI.quit
                  0
                end
              end
            end
            super(listener_name, &(default_behavior_listener || listener))
          end
        end
        
        def content_size(*args)
          if args.empty?
            width = Fiddle::Pointer.malloc(8)
            height = Fiddle::Pointer.malloc(8)
            ::LibUI.window_content_size(@libui, width, height)
            width = width[0, 8].unpack1('i')
            height = height[0, 8].unpack1('i')
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
            handle_listener('on_closing') do
              destroy
              ::LibUI.quit
              0
            end
          end
        end
      end
    end
  end
end
