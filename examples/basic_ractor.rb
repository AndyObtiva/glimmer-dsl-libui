require 'glimmer-dsl-libui'

class BasicRactor
  include Glimmer
  
  def initialize
    @circles_data = []
    setup_circle_factory
  end
  
  def setup_circle_factory
    @circle_factory = Ractor.new do
      loop do
        circle_x_center = rand * 250
        circle_y_center = rand * 250
        circle_radius = rand * 50
        stroke_color = Glimmer::LibUI.x11_colors.sample
        Ractor.yield [[circle_x_center, circle_y_center, circle_radius], nil, stroke_color]
        sleep(rand * 3)
      end
    end
    consumer = Proc.new do
      @circles_data << @circle_factory.take
      @area.queue_redraw_all
      Glimmer::LibUI.queue_main(&consumer)
    end
    Glimmer::LibUI.queue_main(&consumer)
  end
  
  def launch
    window('Color The Circles Game!', 300, 300) {
      vertical_box {
        label('Click on the circles before they disappear to color them and score a point!') {
          stretchy false
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
        }
      }
    }.show
  end
end

BasicRactor.new.launch
