# frozen_string_literal: true

require 'glimmer-dsl-libui'

include Glimmer

menu('File') {
  menu_item('Open') {
    on_clicked do
      file = open_file(MAIN_WINDOW)
      puts file unless file.nil?
    end
  }

  menu_item('Save') {
    on_clicked do
      file = save_file(MAIN_WINDOW)
      puts file unless file.nil?
    end
  }
  
  quit_menu_item {
    on_clicked do
      puts 'Bye Bye'
    end
  }
  
  preferences_menu_item # Can optionally contain an on_clicked listener
}

menu('Edit') {
#   check_menu_item('Checkable Item_')
#   separator_menu_item
  menu_item('Disabled Item_') {
#     enabled false
  }
}

menu('Help') {
  menu_item('Help')
  
  about_menu_item # Can optionally contain an on_clicked listener
}

MAIN_WINDOW = window('Control Gallery', 600, 500, 1) {
  margined 1
  
  on_closing do
    puts 'Bye Bye'
  end
  
#   vertical_box {
#     padded 1
#
#     horizontal_box {
#       padded 1
#
#       group('Basic Controls') {
#         margined 1
#
#         vertical_box {
#           padded 1
#
#           button('Button') {
#             stretchy 0
#
#             on_clicked do
#               msg_box(MAIN_WINDOW, 'Information', 'You clicked the button')
#             end
#           }
#
#           checkbox('Checkbox') { |c|
#             stretchy 0
#
#             on_toggled do
#               checked = c.checked == 1
#               MAIN_WINDOW.title = "Checkbox is #{checked}"
#               c.text = "I am the checkbox (#{checked})"
#             end
#           }
#
#           label('Label') { stretchy 0 }
#
#           horizontal_separator { stretchy 0 }
#
#           date_picker { stretchy 0 }
#
#           time_picker { stretchy 0 }
#
#           date_time_picker { stretchy 0 }
#
#           font_button { stretchy 0 }
#
#           color_button { stretchy 0 }
#         }
#       }
#
#       vertical_box {
#         padded 1
#
#         group('Numbers') {
#           stretchy 0
#           margined 1
#
#           vertical_box {
#             padded 1
#
#             spinbox(0, 100) { |s|
#               stretchy 0
#               value 42
#
#               on_changed do
#                 puts "New Spinbox value: #{s.value}"
#               end
#             }
#
#             slider(0, 100) { |s|
#               stretchy 0
#
#               on_changed do
#                 v = s.value
#                 puts "New Slider value: #{v}"
#                 @progress_bar.value = v
#               end
#             }
#
#             @progress_bar = progress_bar { stretchy 0 }
#           }
#         }
#
#         group('Lists') {
#           stretchy 0
#           margined 1
#
#           vertical_box {
#             padded 1
#
#             combobox { |c|
#               stretchy 0
#               items ['combobox Item 1', 'combobox Item 2', 'combobox Item 3']
#
#               on_selected do
#                 puts "New combobox selection: #{c.selected}"
#               end
#             }
#
#             editable_combobox {
#               stretchy 0
#               items ['Editable Item 1', 'Editable Item 2', 'Editable Item 3']
#             }
#
#             radio_buttons {
#               items ['Radio Button 1', 'Radio Button 2', 'Radio Button 3']
#             }
#           }
#         }
#
#         tab {
#           tab_item {
#             name 'Page 1'
#
#             horizontal_box {
#               entry { |e|
#                 text 'Please enter your feelings'
#
#                 on_changed do
#                   puts "Current textbox data: '#{e.text}'"
#                 end
#               }
#             }
#           }
#
#           tab_item {
#             name 'Page 2'
#
#             horizontal_box
#           }
#
#           tab_item {
#             name 'Page 3'
#
#             horizontal_box
#           }
#         }
#       }
#     }
#   }
}

MAIN_WINDOW.show
