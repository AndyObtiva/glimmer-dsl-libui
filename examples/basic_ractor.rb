require 'glimmer-dsl-libui'

class BasicRactor
  include Glimmer
  
  WINDOW_WIDTH = 800
  WINDOW_HEIGHT = 400
  CIRCLE_MIN_RADIUS = 10
  CIRCLE_MAX_RADIUS = 50
  
  attr_accessor :score
  
  def initialize
    @circles_data = []
    @score = 0
    Glimmer::DataBinding::Observer.proc do
      @score_label.text = @score.to_s
      if @score == -20
        msg_box('You Lost!', 'Sorry! Your score reached -20')
        @score = 0
        @circles_data.clear
      elsif @score == 0
        msg_box('You Won!', 'Congratulations! Your score reached 0')
        @circles_data.clear
      end
    end.observe(self, :score)
    setup_circle_factory
  end
  
  def setup_circle_factory
    @circle_factory = Ractor.new do
      loop do
        circle_x_center = rand * (WINDOW_WIDTH - 2*CIRCLE_MAX_RADIUS) + CIRCLE_MAX_RADIUS
        circle_y_center = rand * (WINDOW_HEIGHT - 2*CIRCLE_MAX_RADIUS) + CIRCLE_MAX_RADIUS
        circle_radius = rand * (CIRCLE_MAX_RADIUS - CIRCLE_MIN_RADIUS) + CIRCLE_MIN_RADIUS
        stroke_color = Glimmer::LibUI.x11_colors.sample
        Ractor.yield [[circle_x_center, circle_y_center, circle_radius], nil, stroke_color]
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
    self.score -= 1
    @area.queue_redraw_all
  end
  
  def launch
    window('Color The Circles Game!', WINDOW_WIDTH, WINDOW_HEIGHT) {
      vertical_box { # TODO switch to grid layout
        # TODO implement restart button
        label('Score goes down as circles are added. If it reaches -20, you lose! Click circles to color and score! Once score reaches 0, you win!') {
          stretchy false
        }
        
        horizontal_box {
          stretchy false
          
          label('Score:') {
            stretchy false
          }
          
          @score_label = label(@score.to_s)
        }
        
        @area = area {
          on_draw do |area_draw_params|
            @circles_data.each do |circle_args, fill_color, stroke_color|
              path {
                circle(*circle_args)
                
                fill fill_color
                stroke stroke_color
              }
            end
          end
          
          on_mouse_down do |area_mouse_event|
            clicked_circle_data = @circles_data.find do |circle_args, fill_color, stroke_color|
              fill_color.nil? && (area_mouse_event[:x] - circle_args[0])**2 + (area_mouse_event[:y] - circle_args[1])**2 < circle_args[2]**2
            end
            if clicked_circle_data
              self.score += 1
              clicked_circle_data[1] = clicked_circle_data[2]
              @area.queue_redraw_all
            end
          end
        }
      }
    }.show
  end
end

BasicRactor.new.launch
