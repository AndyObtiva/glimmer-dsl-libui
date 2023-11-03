require 'glimmer-dsl-libui'

class Counter
  attr_accessor :count
  
  def initialize
    self.count = 0
  end
end

class ButtonCounter
  include Glimmer::LibUI::Application

  before_body do
    @counter = Counter.new
  end

  body {
    window('Hello, Button!', 190, 20) {
      vertical_box {
        button {
          # data-bind button text to @counter count, converting to string on read from model.
          text <= [@counter, :count, on_read: ->(count) {"Count: #{count}"}]
          
          on_clicked do
            # This change will automatically propagate to button text through data-binding above
            @counter.count += 1
          end
        }
      }
    }
  }
end

ButtonCounter.launch
