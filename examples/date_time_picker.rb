# frozen_string_literal: true

require 'glimmer-dsl-libui'

class DateTimePicker
  include Glimmer
  
  attr_accessor :picked_time
  
  def launch
    window('Date Time Pickers', 300, 200) {
      vertical_box {
        date_time_picker {
          time <=> [self, :picked_time, after_write: ->(time) { p time }]
        }
      }
      
      on_closing do
        puts 'Bye Bye'
      end
    }.show
  end
end

DateTimePicker.new.launch
