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

require 'glimmer/fiddle_consumer'

module Glimmer
  module LibUI
    ICON = File.expand_path('../../icons/blank.png', __dir__)
    class << self
      include Glimmer::FiddleConsumer
      
      def integer_to_boolean(int, allow_nil: true, allow_boolean: true)
        int.nil? ? (allow_nil ? nil : false) : (allow_boolean && (int.is_a?(TrueClass) || int.is_a?(FalseClass)) ? int : (int.is_a?(Integer) ? int == 1 : (allow_nil ? nil : false)))
      end
      
      def boolean_to_integer(bool, allow_nil: true, allow_integer: true)
        bool.nil? ? (allow_nil ? nil : 0) : (allow_integer && bool.is_a?(Integer) ? bool : (bool.is_a?(TrueClass) || bool.is_a?(FalseClass) ? (bool == true ? 1 : 0) : (allow_nil ? nil : 0)))
      end
      
      def column_sort_indicator_to_integer(value)
        return value if value.is_a?(Integer)
        
        if value.nil?
          0
        elsif 'ascending'.start_with?(value.to_s)
          1
        elsif 'descending'.start_with?(value.to_s)
          2
        else
          0
        end
      end
      
      def integer_to_column_sort_indicator(value)
        return value if value.is_a?(String) || value.is_a?(Symbol)
        
        case value
        when 1
          :ascending
        when 2
          :descending
        else
          nil
        end
      end
      
      def degrees_to_radians(degrees)
        ((Math::PI * 2.0) / 360.00) * degrees.to_f
      end
      
      def interpret_color(value)
        if value.is_a?(Array) && value.last.is_a?(Hash)
          options = value.last
          value = value[0...-1]
        end
        value = value.first if value.is_a?(Array) && value.size == 1
        value = value[:color] if value.is_a?(Hash) && value[:color]
        value = value.to_s if value.is_a?(Symbol)
        result = if value.is_a?(Array)
          old_value = value
          value = {
            r: old_value[0],
            g: old_value[1],
            b: old_value[2],
          }
          value[:a] = old_value[3] unless old_value[3].nil?
          value
        elsif value.is_a?(Hash)
          old_value = value
          value = old_value.dup
          value[:r] = value.delete(:red) if value[:red]
          value[:g] = value.delete(:green) if value[:green]
          value[:b] = value.delete(:blue) if value[:blue]
          value[:a] = value.delete(:alpha) if value[:alpha]
          value
        elsif value.is_a?(String) && !value.start_with?('0x') && !value.start_with?('#') && !value.downcase.match(/^((([1-9a-f]){6})|(([1-9a-f]){3}))$/)
          require 'color'
          color = Color::RGB.extract_colors(value).first
          color.nil? ? {} : {
            r: color.red,
            g: color.green,
            b: color.blue,
          }
        else
          hex_to_rgb(value)
        end
        result.merge!(options) if options
        result
      end
      
      # returns whether the value represents no color (blank) or a present color
      # when a path is first built, it has a blank color
      def blank_color?(value)
        value.nil? ||
          (value.respond_to?(:empty?) && value.empty?) ||
          (value.is_a?(Array) && value.compact.empty?) ||
          (value.is_a?(Hash) && value.values.compact.empty?)
      end
      
      # returns a representation of a blank color
      # when a path is first built, it has a blank color
      def blank_color
        [{}]
      end
    
      def hex_to_rgb(value)
        if value.is_a?(String)
          value = value[2..-1] if value.start_with?('0x')
          value = value[1..-1] if value.start_with?('#')
          value = value.chars.map {|char| [char, char]}.flatten.join if value.length == 3
          value = value.to_i(16)
        end
        if value.is_a?(Integer)
          hex_value = value
          value = {
            r: ((hex_value >> 16) & 0xFF),
            g: ((hex_value >> 8) & 0xFF),
            b: (hex_value & 0xFF),
          }
        end
        value
      end
      
      def enum_symbols(enum_name)
        enum_symbol_values(enum_name).keys
      end
      
      def enum_names
       [
         :align,
         :at,
         :attribute_type,
         :draw_brush_type,
         :draw_fill_mode,
         :draw_line_cap,
         :draw_line_join,
         :draw_text_align,
         :ext_key,
         :modifier,
         :table_model_column,
         :table_value_type,
         :text_italic,
         :text_stretch,
         :text_weight,
         :underline,
         :underline_color
       ]
      end
      
      # Returns ruby underscored symbols for enum values starting with enum name (camelcase, e.g. 'ext_key')
      def enum_symbol_values(enum_name)
        enum_name = enum_name.to_s.underscore.to_sym
        @enum_symbols ||= {}
        @enum_symbols[enum_name] ||= ::LibUI.constants.select do |c|
          c.to_s.match(/#{enum_name.to_s.camelcase(:upper)}[A-Z]/)
        end.map do |c|
          [c.to_s.underscore.sub("#{enum_name}_", '').to_sym, ::LibUI.const_get(c)]
        end.reject do |key, value|
          enum_name == :underline && key.to_s.start_with?('color')
        end.to_h
      end
      
      def enum_value_to_symbol(enum_name, enum_value)
        enum_symbol_values(enum_name).invert[enum_value]
      end
      
      def enum_symbol_to_value(enum_name, enum_symbol, default_symbol: nil, default_index: 0)
        if enum_symbol.is_a?(Integer)
          enum_symbol
        elsif enum_symbols(enum_name).include?(enum_symbol.to_s.to_sym)
          enum_symbol_values(enum_name)[enum_symbol.to_s.to_sym]
        elsif default_symbol
          enum_symbol_to_value(enum_name, default_symbol)
        else
          enum_symbol_to_value(enum_name, enum_symbols(enum_name)[default_index])
        end
      end
      
      def x11_colors
        begin
          require 'color/rgb/colors'
        rescue
          require 'color'
        end
        Color::RGB.constants.reject {|c| c.to_s.upcase == c.to_s}.map(&:to_s).map(&:underscore).map(&:to_sym)
      end
      
      # Returns OS shortcut key, meaning the key used with most shorcuts,
      # like :command on the Mac (used in CMD+S for save)
      # or :control on Windows and Linux (used in CONTROL+S for save)
      def os_shortcut_key
        @os_shortcut_key ||= OS.mac? ? :command : :ctrl
      end
      
      # Queues block to execute at the nearest opportunity possible on the main GUI event loop
      def queue_main(&block)
        closure = fiddle_closure_block_caller(4, [0]) do
          result = boolean_to_integer(block.call)
          result = 1 if result.nil?
          result
        end
        ::LibUI.queue_main(closure)
        closure
      end
      
      # Calls block on the main GUI event loop after time_in_seconds delay, repeating indefinitely by default
      # If `repeat:` keyword arg is passed with an Integer value, it repeats for that number of times
      # If `repeat:` keyword arg is passed with false or 0, then the block is only called once
      # If block returns false at any point, the timer is stopped from further repetitions regardless of `repeat:` keyword arg value
      # If block returns true at any point, the timer continues for another repetition regardless of `repeat:` keyword arg value
      def timer(time_in_seconds = 0.1, repeat: true, &block)
        closure = fiddle_closure_block_caller(4, [0]) do
          result = boolean_to_integer(block.call, allow_integer: false)
          repeat -= 1 if repeat.is_a?(Integer)
          if result.nil?
            if (repeat == true || (repeat.is_a?(Integer) && repeat > 0))
              result = 1
            else
              result = 0
            end
          end
          result
        end
        ::LibUI.timer(time_in_seconds * 1000.0, closure)
        closure
      end
      
      def respond_to?(method_name, *args)
        super || ::LibUI.respond_to?(method_name, *args)
      end
      
      def method_missing(method_name, *args, &block)
        if ::LibUI.respond_to?(method_name, true)
          ::LibUI.send(method_name, *args, &block)
        else
          super
        end
      end
    end
  end
end
