require 'glimmer-dsl-libui'

class BasicRactor
  include Glimmer
  
  WINDOW_WIDTH = 800
  WINDOW_HEIGHT = 600
  CIRCLE_MIN_RADIUS = 15
  CIRCLE_MAX_RADIUS = 50
  MARGIN_WIDTH = 55
  MARGIN_HEIGHT = 155
  
  attr_accessor :score
  
  def initialize
    @circles_data = []
    @score = 0
    register_observers
    setup_circle_factory
  end
  
  def register_observers
    observer = Glimmer::DataBinding::Observer.proc do |new_score|
      @score_label.text = new_score.to_s
      if new_score == -20
        msg_box('You Lost!', 'Sorry! Your score reached -20')
        @score = 0 # update variable directly to avoid notifying observers
        @circles_data.clear
      elsif new_score == 0
        msg_box('You Won!', 'Congratulations! Your score reached 0')
        @circles_data.clear
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
      Glimmer::LibUI.timer(rand * 2, repeat: false, &consumer)
    end
    Glimmer::LibUI.queue_main(&consumer)
  end
  
  def generate_circle
    @circles_data << @circle_factory.take
    @area.queue_redraw_all
    self.score -= 1 # notifies score observers automatically of change
  end
  
  def launch
    window('Color The Circles', WINDOW_WIDTH, WINDOW_HEIGHT) {
      margined true
      
      grid {
        button('Restart') {
          left 0
          top 0
          halign :center
          
          on_clicked do
            @score = 0 # update variable directly to avoid notifying observers
            @circles_data.clear
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
