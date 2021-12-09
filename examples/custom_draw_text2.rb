require 'glimmer-dsl-libui'

# Michael Ende (1929-1995)
# The Neverending Story is a fantasy novel by German writer Michael Ende,
# The English version, translated by Ralph Manheim, was published in 1983.
class CustomDrawText
  include Glimmer
  
  def launch
    window('Michael Ende (1929-1995) The Neverending Story', 600, 500) {
      margined true
      
      vertical_box {
        form {
          stretchy false
          
          font_button { |fb|
            label 'Font'
            
            on_changed do
              @font = fb.font
              @area.queue_redraw_all
            end
          }

          color_button { |cb|
            label 'Color'
            
            on_changed do
              @color = cb.color
              @area.queue_redraw_all
            end
          }
          
          unless OS.windows?
            color_button { |cb|
              label 'Background'
              
              on_changed do
                @background = cb.color
                @area.queue_redraw_all
              end
            }
          end

          combobox { |c|
            label 'Underline'
            items Glimmer::LibUI.enum_symbols(:underline).map(&:to_s).map {|word| word.split('_').map(&:capitalize).join(' ')}
            selected 'None'
            
            on_selected do
              @underline = c.selected_item.underscore
              @area.queue_redraw_all
            end
          }

          combobox { |c|
            label 'Underline Built-In Color'
            items Glimmer::LibUI.enum_symbols(:underline_color).map(&:to_s).map(&:capitalize)
            selected 'Custom'
            
            on_selected do
              @underline_custom_color_button.enabled = c.selected_item == 'Custom'
              if c.selected_item == 'Custom'
                @underline_color = @underline_custom_color_button.color
              else
                @underline_color = c.selected_item.underscore
                @underline_custom_color_button.color = :black
              end
              @area.queue_redraw_all
            end
          }

          @underline_custom_color_button = color_button {
            label 'Underline Custom Color'
            
            on_changed do
              @underline_color = @underline_custom_color_button.color
              @area.queue_redraw_all
            end
          }
        }
        
        @area = area {
          on_draw do |area_draw_params|
            text { # default arguments for x, y, and width are (0, 0, area_draw_params[:area_width] - 2*x)
              # align :left # default alignment
                
              string {
                font @font
                color @color
                background @background
                underline @underline
                underline_color @underline_color
                
                '  At last Ygramul sensed that something was coming toward ' \
                'her. With the speed of lightning, she turned about, confronting ' \
                'Atreyu with an enormous steel-blue face. Her single eye had a ' \
                'vertical pupil, which stared at Atreyu with inconceivable malignancy. ' \
                "\n\n" \
                '  A cry of fear escaped Bastian. ' \
                "\n\n" \
                '  A cry of terror passed through the ravine and echoed from ' \
                'side to side. Ygramul turned her eye to left and right, to see if ' \
                'someone else had arrived, for that sound could not have been ' \
                'made by the boy who stood there as though paralyzed with ' \
                'horror. ' \
                "\n\n" \
                '  Could she have heard my cry? Bastion wondered in alarm. ' \
                "But that's not possible. " \
                "\n\n" \
                '  And then Atreyu heard Ygramuls voice. It was very high ' \
                'and slightly hoarse, not at all the right kind of voice for that ' \
                'enormous face. Her lips did not move as she spoke. It was the ' \
                'buzzing of a great swarm of hornets that shaped itself into ' \
                'words. ' \
                "\n\n"
              }
            }
          end
        }
      }
    }.show
  end
end

CustomDrawText.new.launch
