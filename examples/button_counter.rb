require 'glimmer-dsl-libui'

class ButtonCounter
  include Glimmer

  attr_accessor :count

  def initialize
    @count = 0
  end

  def launch
    window('Hello, Button!', 190, 20) {
      vertical_box {
        button {
          text <= [self, :count, on_read: ->(count) {"Count: #{count}"}] # data-bind button text to self count, converting to string on read.
          
          on_clicked do
            self.count += 1
          end
        }
      }
    }.show
  end
end

ButtonCounter.new.launch
