# Copyright (c) 2021-2024 Andy Maleh
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

require 'glimmer/libui/custom_control'
require 'glimmer/libui/syntax_highlighter'

module Glimmer
  module LibUI
    module CustomControl
      class CodeEntry
        include Glimmer::LibUI::CustomControl
        
        REGEX_COLOR_HEX6 = /^#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/
        # TODO vary shortcut key by OS (CMD for Mac, CTRL elsewhere)
        
        option :language, default: 'ruby'
        option :theme, default: 'glimmer'
        option :code
        option :padding, default: 10
        option :caret_blinking_delay_in_seconds, default: 0.5
        option :font_size, default: 14
        # TODO consider offering the option to autosave to a file upon changes
        
        attr_reader :syntax_highlighter, :line, :position
        
        before_body do
          @syntax_highlighter = SyntaxHighlighter.new(language: language, theme: theme)
          @font_default = {family: OS.mac? ? 'Courier New' : 'Courier', size: font_size, weight: :medium, italic: :normal, stretch: :normal}
          @line = 0
          @position = 5
          @draw_caret = false
          @multiplier_position = 0.6
          @multiplier_line = 1.2
        end
        
        after_body do
          LibUI.timer(caret_blinking_delay_in_seconds/5.0) do
            body_root.redraw
          end
        end
        
        body {
          scrolling_area(1, 1) { |code_entry_area|
            on_draw do
              code_lines = code.lines
              # TODO need to determine the scrolling area width and height from the text extent once supported in the future
              code_entry_area.set_size(code_lines.map(&:size).max * font_size*@multiplier_position, code_lines.size * font_size*@multiplier_line)
              
              rectangle(0, 0, 8000, 8000) {
                fill :white
              }
              
              code_layer
              
              caret_layer if @draw_caret
              
              if @blinking_time.nil? || (Time.now - @blinking_time > caret_blinking_delay_in_seconds)
                @blinking_time = Time.now
                @draw_caret = !@draw_caret
              end
            end
      
            on_mouse_down do |mouse_event|
              # once text extent calculation via libui is supported, consider the idea of splitting
              # text by single characters to use every character extent in determining mouse location
              # or not splitting but using the extent of one character to determine mouse location
              @position = (mouse_event[:x] - padding) / (font_size*@multiplier_position)
              @line = (mouse_event[:y] - padding) / (font_size*@multiplier_line)
              @line = [@line, code.lines.length - 1].min
              @position = [@position, current_code_line.length - 1].min
              body_root.redraw
            end
            # TODO mouse click based text selection
      
            on_key_down do |key_event|
              # TODO consider delegating some of the logic below to a model
              handled = true # assume it is handled for all cases except the else clause below
              case key_event
              in modifiers: [], ext_key: :left
                if @position == 0
                  if @line > 0
                    new_position = code.lines[line - 1].length - 1
                    @line = [@line - 1, 0].max
                    @position = new_position
                  end
                else
                  @position = [@position - 1, 0].max
                end
              in modifiers: [], ext_key: :right
                if @position == current_code_line.length - 1
                  if @line < code.lines.size - 1
                    @line += 1
                    @position = 0
                  end
                else
                  @position += 1
                end
              in modifiers: [], ext_key: :up
                # TODO scroll view when going down or up or paging or going home / end
                @line = [@line - 1, 0].max
                if @max_position
                  @position = @max_position
                  @max_position = nil
                end
              in modifiers: [], ext_key: :down
                @line += 1
                if @max_position
                  @position = @max_position
                  @max_position = nil
                end
              in modifiers: [], ext_key: :page_up
                @line = [@line - 15, 0].max
                if @max_position
                  @position = @max_position
                  @max_position = nil
                end
              in modifiers: [], ext_key: :page_down
                @line += 15
                if @max_position
                  @position = @max_position
                  @max_position = nil
                end
              in modifiers: [], ext_key: :home
                @line = 0
                @position = 0
              in modifiers: [], ext_key: :end
                @line = code.lines.size - 1
                @position = current_code_line.length - 1
              in ext_key: :delete
                code.slice!(caret_index)
              in key: "\n"
                code.insert(caret_index, "\n")
                @line += 1
                @position = 0
                # TODO indent upon hitting enter
              in key: "\b"
                if @position == 0
                  new_position = code.lines[line - 1].length - 1
                  code.slice!(caret_index - 1)
                  @line = [@line - 1, 0].max
                  @position = new_position
                else
                  @position = [@position - 1, 0].max
                  code.slice!(caret_index)
                end
              in key: "\t"
                code.insert(caret_index, '  ')
                @position += 2
              in modifiers: [:control], key: 'a'
                @position = 0
              in modifiers: [:command], ext_key: :left
                @position = 0
              in modifiers: [:control], key: 'e'
                @position = current_code_line.length - 1
              in modifiers: [:command], ext_key: :right
                @position = current_code_line.length - 1
              in modifiers: [:shift], key_code: 48
                code.insert(caret_index, ')')
                @position += 1
              in modifiers: [:alt], ext_key: :right
                if @position == current_code_line.length - 1
                  if @line < code.lines.size - 1
                    @line += 1
                    @position = 0
                  end
                else
                  new_caret_index = caret_index
                  new_caret_index += 1 while code[new_caret_index + 1]&.match(/[^a-zA-Z]/)
                  new_caret_index += 1 until code[new_caret_index + 1].nil? || code[new_caret_index + 1].match(/[^a-zA-Z]/)
                  @position += new_caret_index + 1 - caret_index
                end
              in modifiers: [:alt], ext_key: :left
                if @position == 0
                  if @line > 0
                    new_position = code.lines[line - 1].length - 1
                    @line = [@line - 1, 0].max
                    @position = new_position
                  end
                else
                  new_caret_index = caret_index
                  new_caret_index -= 1 while code[new_caret_index - 1]&.match(/[^a-zA-Z]/)
                  new_caret_index -= 1 until code[new_caret_index + 1].nil? || code[new_caret_index - 1].match(/[^a-zA-Z]/)
                  @position -= caret_index - new_caret_index
                  @position = [@position, 0].max
                end
              in modifier: nil, modifiers: []
                code.insert(caret_index, key_event[:key])
                @position += 1
              in modifier: nil, modifiers: [:shift]
                character = key_event[:key] || key_event[:key_code].chr.capitalize
                code.insert(caret_index, character)
                @position += 1
              # TODO CMD Z (undo)
              # TODO CMD SHIFT Z (redo)
              # TODO CMD + [ (outdent)
              # TODO CMD + ] (indent)
              # TODO CMD + down (move line down)
              # TODO CMD + up (move line up)
              # TODO CMD + D (duplicate)
              else
                handled = false
              end
              @line = [@line, code.lines.length - 1].min
              new_position = [@position, current_code_line.length - 1].min
              if new_position != @position
                @max_position = @position
                @position = new_position
              end
              @draw_caret = true
              body_root.redraw
              handled
            end
          }
        }
        
        def code_layer
          text(padding, padding) {
            default_font @font_default
            
            syntax_highlighter.syntax_highlighting(code).each do |token|
              token_text = token[:token_text].start_with?("\n") ? " #{token[:token_text]}" : token[:token_text]
              
              string(token_text) {
                font @font_default.merge(italic: :italic) if token[:token_style][:italic]
                color token[:token_style][:fg] || :black
                background token[:token_style][:bg] || :white
              }
            end
          }
        end
        
        def caret_layer
          # TODO adjust padding offset based on text extent
          text(padding - 4, padding) {
            default_font @font_default
              
            # TODO make caret blink
            string(caret_text) {
              color :black
              background [0, 0, 0, 0]
            }
          }
        end
        
        def caret_text
          # TODO replace | with a real caret (see if there is an emoji or special character for it)
          ("\n" * @line) + (' ' * @position) + '|'
        end
        
        def caret_index
          code.lines[0..line].join.length - (current_code_line.length - @position)
        end
        
        def current_code_line
          code.lines[@line]
        end
      end
    end
  end
end
