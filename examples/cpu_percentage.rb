# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

data = [
  ['CPU', '0%', 0],
]

Glimmer::LibUI.timer(1) do
  cpu_percentage_value = nil
  if OS.windows?
    cpu_percentage_raw_value = `wmic cpu get loadpercentage`
    cpu_percentage_value = cpu_percentage_raw_value.split("\n")[2].to_f
  elsif OS.mac?
    cpu_percentage_value = `ps -A -o %cpu | awk '{s+=$1} END {print s}'`
  end
  data[0][1] = "#{cpu_percentage_value}%"
  data[0][2] = cpu_percentage_value
end

window('CPU Percentage', 400, 200) {
  vertical_box {
    table {
      text_column('Name')
      text_column('Value')
      progress_bar_column('Percentage')

      cell_rows data # implicit data-binding
    }
  }
}.show
