require 'glimmer-dsl-libui'

include Glimmer

window('Main Window') {
  button('Spawn Child Window') {
    on_clicked do
      window('Child Window') {
        on_closing do
          puts 'Child window is closing'
        end
      }.show
    end
  }
  
  on_closing do
    puts 'Main window is closing'
  end
}.show
