require 'glimmer-dsl-libui'

class Event
  attr_accessor :time
end

class DateTimePickerApplication
  include Glimmer::LibUI::Application
  
  before_body do
    @event = Event.new
  end
  
  body {
    window('Date Time Pickers', 300, 200) {
      date_time_picker {
        time <=> [@event, :time,
                   after_write: ->(time) { p time }
                 ]
      }
    }
  }
end

DateTimePickerApplication.launch
