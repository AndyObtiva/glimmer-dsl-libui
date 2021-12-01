require 'glimmer-dsl-libui'
require 'bigdecimal'

include Glimmer

data = [
  ['CPU', '0%', 0],
]

Glimmer::LibUI.timer(1) do
  cpu_percentage_value = nil
  if OS.windows?
    cpu_percentage_raw_value = `wmic cpu get loadpercentage`
    cpu_percentage_value = cpu_percentage_raw_value.split("\n")[2].to_i
  elsif OS.mac?
    cpu_percentage_value = `ps -A -o %cpu | awk '{s+=$1} END {print s}'`.to_i
  elsif OS.linux?
    stats = `top -n 1`
    idle_percentage = stats.split("\n")[2].match(/ni,.* (.*) .*id/)[1]
    cpu_percentage_value = (BigDecimal(100) - BigDecimal(idle_percentage)).to_i
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
