require 'glimmer-dsl-libui'

# code_entry is experimental/incomplete and not recommended for serious usage
class BasicCodeEntry
  include Glimmer::LibUI::Application
  
  before_body do
    @code = <<~CODE
      # Greets target with greeting
      def greet(greeting: 'Hello', target: 'World')
        puts "\#{greeting}, \#{target}!"
      end
      
      greet
      greet(target: 'Robert')
      greet(greeting: 'Aloha')
      greet(greeting: 'Aloha', target: 'Nancy')
      greet(greeting: 'Howdy', target: 'Doodle')
    CODE
  end
  
  body {
    window('Basic Code Entry', 400, 300) {
      # code_entry is experimental/incomplete and not recommended for serious usage
      code_entry(language: 'ruby', code: @code)
    }
  }
end

BasicCodeEntry.launch
