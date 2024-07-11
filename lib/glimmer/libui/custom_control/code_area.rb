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
      class CodeArea
        include Glimmer::LibUI::CustomControl
        
        REGEX_COLOR_HEX6 = /^#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/
        
        option :language, default: 'ruby'
        option :theme, default: 'glimmer'
        option :code
        option :padding, default: 10
        
        attr_reader :syntax_highlighter
        
        before_body do
          @syntax_highlighter = SyntaxHighlighter.new(language: language, theme: theme)
          @font_default = {family: OS.mac? ? 'Courier New' : 'Courier', size: 13, weight: :medium, italic: :normal, stretch: :normal}
        end
        
        body {
          area {
            rectangle(0, 0, 8000, 8000) {
              fill :white
            }
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
          }
        }
      end
    end
  end
end
