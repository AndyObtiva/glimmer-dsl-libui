require 'glimmer-dsl-libui'

include Glimmer

window('Main Window') { |main_window|
  button('Spawn Child Window') {
    on_clicked do
      window('Child Window') { |child_window|
        on_focus_changed do
          puts 'Child window is focused' if child_window.focused?
        end
        
        on_closing do
          puts 'Child window is closing'
        end
      }.show
    end
  }
  
  on_focus_changed do
    puts 'Main window is focused' if main_window.focused?
  end
  
  on_closing do
    puts 'Main window is closing'
  end
}.show
