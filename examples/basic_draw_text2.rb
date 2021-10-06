
require 'glimmer-dsl-libui'

# Michael Ende (1929-1995)
# The Neverending Story is a fantasy novel by German writer Michael Ende,
# The English version, translated by Ralph Manheim, was published in 1983.
class BasicDrawText
  include Glimmer
  
  def alternating_color_string(initial: false, &block)
    @index = 0 if initial
    @index += 1
    string {
      if @index.odd?
        color r: 0.5, g: 0, b: 0.25, a: 0.7
      else
        color r: 0, g: 0.5, b: 0, a: 0.7
      end
      
      block.call + "\n\n"
    }
  end
  
  def launch
    window('Michael Ende (1929-1995) The Neverending Story', 600, 400) {
      margined true
      
      area {
        on_draw do |area_draw_params|
          text { # default arguments for x, y, and width are (0, 0, area_draw_params[:area_width])
            # align :left # default alignment
            default_font family: 'Georgia', size: 13, weight: 500, italic: 0, stretch: 4
              
            alternating_color_string(initial: true) {
              '  At last Ygramul sensed that something was coming toward ' \
              'her. With the speed of lightning, she turned about, confronting ' \
              'Atreyu with an enormous steel-blue face. Her single eye had a ' \
              'vertical pupil, which stared at Atreyu with inconceivable malignancy. '
            }
            alternating_color_string {
              '  A cry of fear escaped Bastian. '
            }
            alternating_color_string {
              '  A cry of terror passed through the ravine and echoed from ' \
              'side to side. Ygramul turned her eye to left and right, to see if ' \
              'someone else had arrived, for that sound could not have been ' \
              'made by the boy who stood there as though paralyzed with ' \
              'horror. '
            }
            alternating_color_string {
              '  Could she have heard my cry? Bastion wondered in alarm. ' \
              "But that's not possible. "
            }
            alternating_color_string {
              '  And then Atreyu heard Ygramuls voice. It was very high ' \
              'and slightly hoarse, not at all the right kind of voice for that ' \
              'enormous face. Her lips did not move as she spoke. It was the ' \
              'buzzing of a great swarm of hornets that shaped itself into ' \
              'words. '
            }
          }
        end
      }
    }.show
  end
end

BasicDrawText.new.launch
