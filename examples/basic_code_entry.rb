require 'glimmer-dsl-libui'

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
      code_entry(language: 'ruby', code: @code)
    }
  }
end

BasicCodeEntry.launch
