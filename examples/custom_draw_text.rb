require 'glimmer-dsl-libui'

# Michael Ende (1929-1995)
# The Neverending Story is a fantasy novel by German writer Michael Ende,
# The English version, translated by Ralph Manheim, was published in 1983.
class CustomDrawText
  include Glimmer
  
  def launch
    window('Michael Ende (1929-1995) The Neverending Story', 600, 400) {
      margined true
      
      vertical_box {
        form {
          font_button {
            label 'Font'
          }
          color_button { |cb|
            label 'Color'
            
            on_changed do
              @string.color = cb.color
            end
          }
          color_button { |cb|
            label 'Background'
            
            on_changed do
              @string.background = cb.color
            end
          }
          combobox {
            label 'Underline'
          }
        }
        
        area {
          text { # default arguments for x, y, and width are (0, 0, area_draw_params[:area_width])
            # align :left # default alignment
              
            @string = string {
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
              'words. '
            }
          }
        }
      }
    }.show
  end
end

CustomDrawText.new.launch
