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
          @font_default = {family: OS.mac? ? 'Consolas' : 'Courier', size: 13, weight: :medium, italic: :normal, stretch: :normal}
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
              handled = true # assume it is handled for all cases except the else clause below
              case key_event
              in ext_key: :left
                @position = [@position - 1, 0].max
              in ext_key: :right
                @position += 1
              # TODO handle ENTER key
              else
                # returning false explicitly means the key event was not handled, which
                # propagates the event to other handlers, like the quit menu item, which
                # can handle COMMAND+Q on the Mac to quit an application
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
              style_data = Rouge::Theme.find(theme).new.style_for(token[:token_type])
              token_text = token[:token_text].start_with?("\n") ? " #{token[:token_text]}" : token[:token_text]
              
              string(token_text) {
                color style_data[:fg] || :black
                background style_data[:bg] || :white
              }
            end
          }
        end
        
        def caret_layer
          text(padding, padding) {
            default_font @font_default
              
            # TODO perhaps instead of this approach, try to calculate text extent as that is supported by libui
            string(caret_text) {
              color :black
              background [0, 0, 0, 0]
            }
          }
        end
        
        def caret_text
          ("\n" * line) + (' ' * position) + '|'
        end
      end
    end
  end
end
