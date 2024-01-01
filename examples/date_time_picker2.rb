require 'glimmer-dsl-libui'

include Glimmer

window('Date Time Pickers', 300, 200) {
  date_time_picker { |dtp|
    on_changed do
      time = dtp.time
      p time
    end
  }
}.show
