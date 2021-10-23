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
        
        LISTENERS = ['on_draw', 'on_mouse_event', 'on_mouse_move', 'on_mouse_down', 'on_mouse_up', 'on_mouse_drag_start', 'on_mouse_drag', 'on_mouse_drop', 'on_mouse_crossed', 'on_mouse_enter', 'on_mouse_exit', 'on_drag_broken', 'on_key_event', 'on_key_down', 'on_key_up']
        LISTENER_ALIASES = {
          on_drawn: 'on_draw',
          on_mouse_moved: 'on_mouse_move',
          on_mouse_drag_started: 'on_mouse_drag_start',
          on_mouse_dragged: 'on_mouse_drag',
          on_mouse_dropped: 'on_mouse_drop',
          on_mouse_cross: 'on_mouse_crossed',
          on_mouse_entered: 'on_mouse_enter',
          on_mouse_exited: 'on_mouse_exit',
          on_drag_break: 'on_drag_broken',
        }
        SHIFTED_KEY_CODE_CHARS = {
          '`' => '~',
          '1' => '!',
          '2' => '@',
          '3' => '#',
          '4' => '$',
          '5' => '%',
          '6' => '^',
          '7' => '&',
          '8' => '*',
          '9' => '(',
          '10' => ')',
          '-' => '_',
          '=' => '+',
          ',' => '<',
          '.' => '>',
          '/' => '?',
          ';' => ':',
          "'" => '"',
          '[' => '{',
          ']' => '}',
          "\\" => '|',
        }

        
        include Glimmer::FiddleConsumer
        include Parent
        prepend Transformable
        
        attr_reader :area_handler
        
        def libui_api_keyword
          'area'
        end
        
        def post_add_content
          unless parent_proxy.is_a?(Box)
            original_parent_proxy = @parent_proxy
            @vertical_box_parent_proxy = ControlProxy.create('vertical_box', parent_proxy, []) {} # block prevents calling post add content
            append_properties.each do |property|
              @vertical_box_parent_proxy.append_property(property, append_property(property))
            end
            @vertical_box_parent_proxy.post_add_content
            @parent_proxy = @vertical_box_parent_proxy
            @vertical_box_parent_proxy.post_initialize_child(self)
          else
            super
          end
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
            on_mouse_move.each { |listener| listener.call(area_mouse_event)} if area_mouse_event[:x].between?(0, area_mouse_event[:area_width]) && area_mouse_event[:y].between?(0, area_mouse_event[:area_height])
            unless @last_area_mouse_event.nil?
              on_mouse_down.each { |listener| listener.call(area_mouse_event)} if area_mouse_event[:down] > 0 && @last_area_mouse_event[:down] == 0
              on_mouse_up.each { |listener| listener.call(area_mouse_event)} if area_mouse_event[:up] > 0 && @last_area_mouse_event[:up] == 0
              on_mouse_drag_start.each { |listener| listener.call(area_mouse_event)} if area_mouse_event[:held] > 0 && @last_area_mouse_event[:held] == 0
              on_mouse_drag.each { |listener| listener.call(area_mouse_event)} if area_mouse_event[:held] > 0
              on_mouse_drop.each { |listener| listener.call(area_mouse_event)} if area_mouse_event[:held] == 0 && @last_area_mouse_event[:held] > 0
            end
            @last_area_mouse_event = area_mouse_event
          end
          @area_handler.MouseCrossed = fiddle_closure_block_caller(0, [1, 1, 4]) do |_, _, left|
            left = Glimmer::LibUI.integer_to_boolean(left)
            on_mouse_crossed.each { |listener| listener.call(left) }
            if left
              on_mouse_exit.each { |listener| listener.call(left) }
            else
              on_mouse_enter.each { |listener| listener.call(left) }
            end
          end
          @area_handler.DragBroken   = fiddle_closure_block_caller(0, [1, 1]) do |_, _|
            on_drag_broken.each { |listener| listener.call }
          end
          @area_handler.KeyEvent     = fiddle_closure_block_caller(0, [1, 1, 1]) do |_, _, area_key_event|
            area_key_event = ::LibUI::FFI::AreaKeyEvent.new(area_key_event)
            area_key_event = area_key_event_hash(area_key_event)
            on_key_event.each { |listener| listener.call(area_key_event) }
            if area_key_event[:up]
              on_key_up.each { |listener| listener.call(area_key_event) }
            else
              on_key_down.each { |listener| listener.call(area_key_event) }
            end
          end
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
        
        def area_key_event_hash(area_key_event)
          modifiers = modifiers_to_symbols(area_key_event.Modifiers)
          {
            key: key_to_char(area_key_event.Key, modifiers),
            key_value: area_key_event.Key,
            ext_key: ext_key_to_symbol(area_key_event.ExtKey),
            ext_key_value: area_key_event.ExtKey,
            modifier: modifiers_to_symbols(area_key_event.Modifier).first,
            modifiers: modifiers,
            up: Glimmer::LibUI.integer_to_boolean(area_key_event.Up),
          }
        end
        
        def key_to_char(key, modifiers = [])
          if key > 0
            char = key.chr
            if modifiers == [:shift]
              SHIFTED_KEY_CODE_CHARS[char]
            else
              char
            end
          end
        end
        
        def ext_key_to_symbol(ext_key_value)
          Glimmer::LibUI.enum_value_to_symbol(:ext_key, ext_key_value)
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

Dir[File.expand_path("./#{File.basename(__FILE__, '.rb')}/*.rb", __dir__)].each {|f| require f}
