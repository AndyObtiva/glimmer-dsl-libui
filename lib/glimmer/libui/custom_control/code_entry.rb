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
        
        option :language, default: 'ruby'
        option :theme, default: 'glimmer'
        option :code
        option :padding, default: 10
        
        attr_reader :syntax_highlighter, :line, :position
        
        before_body do
          @syntax_highlighter = SyntaxHighlighter.new(language: language, theme: theme)
          @font_default = {family: OS.mac? ? 'Courier New' : 'Courier', size: 13, weight: :medium, italic: :normal, stretch: :normal}
          @line = 0
          @position = 5
        end
        
        body {
          area {
            on_draw do
              rectangle(0, 0, 8000, 8000) {
                fill :white
              }
              code_layer
              caret_layer
            end
      
            on_key_down do |key_event|
              # TODO consider delegating some of the logic below to a model
              handled = true # assume it is handled for all cases except the else clause below
              case key_event
              in ext_key: :left
                # TODO jump to the previous line once reaching the beginning of a line
                @position = [@position - 1, 0].max
              in ext_key: :right # TODO do not go beyond right limit
                # TODO jump to the next line once reaching the end of a line
                @position += 1
              in ext_key: :up # TODO do not go beyond right limit
                @line = [@line - 1, 0].max
              in ext_key: :down # TODO do not go beyond right limit
                @line += 1
              in ext_key: :delete
                code.slice!(caret_index)
              in key: "\n"
                @line += 1
                @position = 0
                # TODO split the text if we are in the middle of the text
                # add a new line too
              in key: "\b"
                @position = [@position - 1, 0].max
                # TODO go back one line up if at position 0
                code.slice!(caret_index)
              in key: "\t"
                code.insert(caret_index, '  ')
                @position += 2
                # TODO go back one line up if at position 0
              in modifier: nil, modifiers: []
                code.insert(caret_index, key_event[:key])
                @position += 1
              in modifier: nil, modifiers: [:shift]
                character = key_event[:key] || key_event[:key_code].chr.capitalize
                code.insert(caret_index, character)
                @position += 1
              # TODO handle undo and redo
              # CTRL+A
              # CTRL+E
              # FN+LEFT for Home
              # FN+RIGHT for End
              # FN+UP for Page Up
              # FN+Down for Page Down
              else
                # TODO insert typed characters into code
                handled = false
              end
              body_root.redraw
              handled
            end
          }
        }
        
        def code_layer
          text(padding, padding) {
            default_font @font_default
            
            # TODO cache this work if not changed between renders
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
          text(padding, padding) {
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
          ("\n" * line) + (' ' * position) + '|'
        end
        
        def caret_index
          code.lines[0..line].join.length - (code.lines[line].length - position)
        end
      end
    end
  end
end
