# Copyright (c) 2021-2023 Andy Maleh
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

module Glimmer
  module LibUI
    module CustomControl
      class CodeArea
        class << self
          def languages
            require 'rouge'
            Rouge::Lexer.all.map {|lexer| lexer.tag}.sort
          end
          
          def lexers
            require 'rouge'
            Rouge::Lexer.all.sort_by(&:title)
          end
        end
        
        include Glimmer::LibUI::CustomControl
        
        REGEX_COLOR_HEX6 = /^#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$/
        
        option :language, default: 'ruby'
        option :theme, default: 'glimmer'
        option :code
        
        body {
          area {
            rectangle(0, 0, 8000, 8000) {
              fill :white
            }
            text {
              default_font family: OS.mac? ? 'Consolas' : 'Courier', size: 13, weight: :medium, italic: :normal, stretch: :normal
              
              syntax_highlighting(code).each do |token|
                style_data = Rouge::Theme.find(theme).new.style_for(token[:token_type])
               
                string(token[:token_text]) {
                  color style_data[:fg] || :black
                  background style_data[:bg] || :white
                }
              end
            }
          }
        }
        
        def lexer
          require 'rouge'
          require 'glimmer-dsl-libui/ext/rouge/theme/glimmer'
          # TODO Try to use Rouge::Lexer.find_fancy('guess', code) in the future to guess the language or otherwise detect it from file extension
          @lexer ||= Rouge::Lexer.find_fancy(language)
          @lexer ||= Rouge::Lexer.find_fancy('ruby') # default to Ruby if no lexer is found
        end
        
        def syntax_highlighting(text)
          return [] if text.to_s.strip.empty?
          @syntax_highlighting ||= {}
          unless @syntax_highlighting.keys.include?(text)
            lex = lexer.lex(text).to_a
            text_size = 0
            @syntax_highlighting[text] = lex.map do |pair|
              {token_type: pair.first, token_text: pair.last}
            end.each do |hash|
              hash[:token_index] = text_size
              text_size += hash[:token_text].size
            end
          end
          @syntax_highlighting[text]
        end
      end
    end
  end
end
