module Rouge
  module Themes
    # A port of the pastie style from Pygments.
    # See https://bitbucket.org/birkenfeld/pygments-main/src/default/pygments/styles/pastie.py
    class Glimmer < Github
      name 'glimmer'
      style Comment::Single, fg:      [106,115,125], italic: true # Also, Comments
      style Keyword::Pseudo, fg:      [:dark_red]
      style Keyword, fg:     [:blue]
      style Literal::String::Single, fg:      [106,115,125] # Also, Comments
      style Literal::String::Double, fg:     [0,92,197]
      style Literal::String::Escape, fg:      [:red]
      style Literal::Number::Integer, fg:     [:blue]
      style Literal::String::Interpol, fg:    [:blue]
      style Literal::String::Symbol, fg:      [:dark_green]
      style Literal::String, fg:      [:dark_blue]
      style Name::Builtin, fg:     [215,58,73]
      style Name::Class, fg:       [3,47,98]
      style Name::Namespace, fg: [3,47,98]
      style Name::Constant, fg:    [0,92,197]
      style Name::Function, fg:    [:blue]
      style Name::Variable::Instance, fg:    [227,98,9]
      style Name, fg:        [111,66,193] #purple
      style Operator, fg:    [:red]
      style Punctuation, fg: [:blue]
      style Text, fg:        [75, 75, 75]
    end
  end
end
