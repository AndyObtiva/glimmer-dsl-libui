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
require 'glimmer/fiddle_consumer'
require 'glimmer/libui/parent'
require 'glimmer/libui/control_proxy/transformable'

module Glimmer
  module LibUI
    class ControlProxy
      # Proxy for LibUI area objects
      #
      # Follows the Proxy Design Pattern
      class AreaProxy < ControlProxy
        class << self
          # this attribute is only populated during on_draw call
          attr_accessor :current_area_draw_params
        end
        
        LISTENERS = ['on_draw', 'on_mouse_event', 'on_mouse_down', 'on_mouse_up']
        
        include Glimmer::FiddleConsumer
        include Parent
        prepend Transformable
        
        attr_reader :area_handler
        
        def post_add_content
          super
          install_listeners
        end
        
        def draw(area_draw_params)
          children.dup.each {|child| child.draw(area_draw_params)}
          on_draw.each {|listener| listener.call(area_draw_params)}
        end
        
        def redraw
          queue_redraw_all
        end
        
        private
        
        def build_control
          @area_handler = ::LibUI::FFI::AreaHandler.malloc
          @libui    = ::LibUI.new_area(@area_handler)
        end
        
        def install_listeners
          @area_handler.Draw         = fiddle_closure_block_caller(0, [1, 1, 1]) do |_, _, area_draw_params|
            area_draw_params = ::LibUI::FFI::AreaDrawParams.new(area_draw_params)
            area_draw_params = area_draw_params_hash(area_draw_params)
            AreaProxy.current_area_draw_params = area_draw_params
            draw(area_draw_params)
            AreaProxy.current_area_draw_params = nil
          end
          @area_handler.MouseEvent   = fiddle_closure_block_caller(0, [1, 1, 1]) do |_, _, area_mouse_event|
            area_mouse_event = ::LibUI::FFI::AreaMouseEvent.new(area_mouse_event)
            area_mouse_event = area_mouse_event_hash(area_mouse_event)
            on_mouse_event.each { |listener| listener.call(area_mouse_event)}
            unless @last_area_mouse_event.nil?
              on_mouse_down.each { |listener| listener.call(area_mouse_event)} if area_mouse_event[:down] > 0 && @last_area_mouse_event[:down] == 0
              on_mouse_up.each { |listener| listener.call(area_mouse_event)} if area_mouse_event[:up] > 0 && @last_area_mouse_event[:up] == 0
            end
            @last_area_mouse_event = area_mouse_event
          end
          @area_handler.MouseCrossed = fiddle_closure_block_caller(0, [0]) {}
          @area_handler.DragBroken   = fiddle_closure_block_caller(0, [0]) {}
          @area_handler.KeyEvent     = fiddle_closure_block_caller(0, [0]) {}
        end
        
        def area_draw_params_hash(area_draw_params)
          {
            context: area_draw_params.Context,
            area_width: area_draw_params.AreaWidth,
            area_height: area_draw_params.AreaHeight,
            clip_x: area_draw_params.ClipX,
            clip_y: area_draw_params.ClipY,
            clip_width: area_draw_params.ClipWidth,
            clip_height: area_draw_params.ClipHeight,
          }
        end
        
        def area_mouse_event_hash(area_mouse_event)
          {
            x: area_mouse_event.X,
            y: area_mouse_event.Y,
            area_width: area_mouse_event.AreaWidth,
            area_height: area_mouse_event.AreaHeight,
            down: area_mouse_event.Down,
            up: area_mouse_event.Up,
            count: area_mouse_event.Count,
            modifers: modifiers_to_symbols(area_mouse_event.Modifiers),
            held: area_mouse_event.Held1To64,
          }
        end
        
        def modifiers_to_symbols(modifiers_value)
          symbols = []
          modifiers_value = extract_symbol_from_modifiers_value(modifiers_value, symbols: symbols) while modifiers_value > 0
          symbols
        end
        
        def extract_symbol_from_modifiers_value(modifiers_value, symbols: )
          if modifiers_value >= 8
            symbols << :command
            modifiers_value -= 8
          elsif modifiers_value >= 4
            symbols << :shift
            modifiers_value -= 4
          elsif modifiers_value >= 2
            symbols << :alt
            modifiers_value -= 2
          elsif modifiers_value >= 1
            symbols << :control
            modifiers_value -= 1
          end
        end
      end
    end
  end
end
