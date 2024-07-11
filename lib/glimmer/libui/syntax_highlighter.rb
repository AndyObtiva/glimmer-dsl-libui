class SyntaxHighlighter
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
  
  attr_reader :language, :theme
  
  def initialize(language:, theme:)
    @language = language
    @theme = theme
  end
  
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
