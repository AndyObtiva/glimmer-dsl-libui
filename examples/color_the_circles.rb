require 'glimmer-dsl-libui'

class BasicRactor
  include Glimmer
  
  WINDOW_WIDTH = 800
  WINDOW_HEIGHT = 600
  CIRCLE_MIN_RADIUS = 15
  CIRCLE_MAX_RADIUS = 50
  MARGIN_WIDTH = 55
  MARGIN_HEIGHT = 155
  TIME_MAX_EASY = 4
  TIME_MAX_MEDIUM = 3
  TIME_MAX_HARD = 2
  TIME_MAX_INSANE = 1
  
  attr_accessor :score
  
  def initialize
    @circles_data = []
    @score = 0
    @time_max = TIME_MAX_HARD
    register_observers
    setup_circle_factory
  end
  
  def register_observers
    observer = Glimmer::DataBinding::Observer.proc do |new_score|
      @score_label.text = new_score.to_s
      if new_score == -20
        msg_box('You Lost!', 'Sorry! Your score reached -20')
        restart_game
      elsif new_score == 0
        msg_box('You Won!', 'Congratulations! Your score reached 0')
        restart_game
      end
    end
    observer.observe(self, :score) # automatically enhances self to become Glimmer::DataBinding::ObservableModel and notify observer on score attribute changes
  end
  
  def setup_circle_factory
    @circle_factory = Ractor.new do
      loop do
        circle_x_center = rand * (WINDOW_WIDTH - MARGIN_WIDTH - CIRCLE_MAX_RADIUS) + CIRCLE_MAX_RADIUS
        circle_y_center = rand * (WINDOW_HEIGHT - MARGIN_HEIGHT - CIRCLE_MAX_RADIUS) + CIRCLE_MAX_RADIUS
        circle_radius = rand * (CIRCLE_MAX_RADIUS - CIRCLE_MIN_RADIUS) + CIRCLE_MIN_RADIUS
        stroke_color = Glimmer::LibUI.x11_colors.sample
        Ractor.yield({
          args: [circle_x_center, circle_y_center, circle_radius],
          fill: nil,
          stroke: stroke_color
        })
      end
    end
    consumer = Proc.new do
      if @circles_data.empty?
        # start with 3 circles to make more challenging
        generate_circle until @circles_data.size > 3
      else
        generate_circle
      end
      Glimmer::LibUI.timer(rand * @time_max, repeat: false, &consumer)
    end
    Glimmer::LibUI.queue_main(&consumer)
  end
  
  def generate_circle
    @circles_data << @circle_factory.take
    @area.queue_redraw_all
    self.score -= 1 # notifies score observers automatically of change
  end
  
  def restart_game
    @score = 0 # update variable directly to avoid notifying observers
    @circles_data.clear
  end
  
  def launch
    menu('Actions') {
      menu_item('Restart') {
        on_clicked do
          restart_game
        end
      }
      
      quit_menu_item
    }
    
    menu('Difficulty') {
      radio_menu_item('Easy') {
        on_clicked do
          @time_max = TIME_MAX_EASY
        end
      }
      
      radio_menu_item('Medium') {
        on_clicked do
          @time_max = TIME_MAX_MEDIUM
        end
      }
      
      radio_menu_item('Hard') {
        checked true
        
        on_clicked do
          @time_max = TIME_MAX_HARD
        end
      }
      
      radio_menu_item('Insane') {
        on_clicked do
          @time_max = TIME_MAX_INSANE
        end
      }
    }
    
    menu('Help') {
      menu_item('Instructions') {
        on_clicked do
          msg_box('Instructions', "Score goes down as circles are added.\nIf it reaches -20, you lose!\n\nClick circles to color and score!\nOnce score reaches 0, you win!\n\nBeware of concealed light-colored circles!\nThey are revealed once darker circles intersect them.\n\nThere are four levels of difficulty.\nChange via difficulty menu if the game gets too tough.")
        end
      }
    }
    
    window('Color The Circles', WINDOW_WIDTH, WINDOW_HEIGHT) {
      margined true
      
      grid {
        button('Restart') {
          left 0
          top 0
          halign :center
          
          on_clicked do
            restart_game
          end
        }
        
        label('Score goes down as circles are added. If it reaches -20, you lose!') {
          left 0
          top 1
          halign :center
        }
        
        label('Click circles to color and score! Once score reaches 0, you win!') {
          left 0
          top 2
          halign :center
        }
        
        horizontal_box {
          left 0
          top 3
          halign :center
          
          label('Score:') {
            stretchy false
          }
          
          @score_label = label(@score.to_s) {
            stretchy false
          }
        }
        
        @area = area {
          left 0
          top 4
          halign :fill
          
          on_draw do |area_draw_params|
            path {
              rectangle(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)
              
              fill :white
            }
            
            @circles_data.each do |circle_data|
              path {
                circle_data[:circle] = circle(*circle_data[:args])
                
                fill circle_data[:fill]
                stroke circle_data[:stroke]
              }
            end
          end
          
          on_mouse_down do |area_mouse_event|
            clicked_circle_data = @circles_data.find do |circle_data|
              circle_data[:fill].nil? && circle_data[:circle].include?(area_mouse_event[:x], area_mouse_event[:y])
            end
            if clicked_circle_data
              clicked_circle_data[:fill] = clicked_circle_data[:stroke]
              @area.queue_redraw_all
              self.score += 1 # notifies score observers automatically of change
            end
          end
        }
      }
    }.show
  end
end

BasicRactor.new.launch
