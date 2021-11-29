# https://github.com/jamescook/libui-ruby/blob/master/example/histogram.rb

require 'glimmer-dsl-libui'

class Histogram
  include Glimmer
  
  X_OFF_LEFT   = 20
  Y_OFF_TOP    = 20
  X_OFF_RIGHT  = 20
  Y_OFF_BOTTOM = 20
  POINT_RADIUS = 5
  COLOR_BLUE   = Glimmer::LibUI.interpret_color(0x1E90FF)
  
  attr_accessor :datapoints, :histogram_color
  
  def initialize
    @datapoints   = 10.times.map {Random.new.rand(90)}
    @histogram_color        = COLOR_BLUE
  end
  
  def graph_size(area_width, area_height)
    graph_width = area_width - X_OFF_LEFT - X_OFF_RIGHT
    graph_height = area_height - Y_OFF_TOP - Y_OFF_BOTTOM
    [graph_width, graph_height]
  end
  
  def point_locations(width, height)
    xincr = width / 9.0 # 10 - 1 to make the last point be at the end
    yincr = height / 100.0
  
    @datapoints.each_with_index.map do |value, i|
      val = 100 - value
      [xincr * i, yincr * val]
    end
  end
  
  # method-based custom control representing a graph path
  def graph_path(width, height, should_extend, &block)
    locations = point_locations(width, height).flatten
    path {
      if should_extend
        polygon(locations + [width, height, 0, height])
      else
        polyline(locations)
      end
      
      # apply a transform to the coordinate space for this path so (0, 0) is the top-left corner of the graph
      transform {
        translate X_OFF_LEFT, Y_OFF_TOP
      }
      
      block.call
    }
  end
  
  def launch
    window('histogram example', 640, 480) {
      margined true
      
      horizontal_box {
        vertical_box {
          stretchy false
          
          10.times do |i|
            spinbox(0, 100) { |sb|
              stretchy false
              value <=> [self, "datapoints[#{i}]", after_write: -> { @area.queue_redraw_all }]
            }
          end
          
          color_button { |cb|
            stretchy false
            color COLOR_BLUE
            
            on_changed do
              @histogram_color = cb.color
              @area.queue_redraw_all
            end
          }
        }
        
        @area = area {
          on_draw do |area_draw_params|
            rectangle(0, 0, area_draw_params[:area_width], area_draw_params[:area_height]) {
              fill 0xFFFFFF
            }
            
            graph_width, graph_height = *graph_size(area_draw_params[:area_width], area_draw_params[:area_height])
          
            figure(X_OFF_LEFT, Y_OFF_TOP) {
              line(X_OFF_LEFT, Y_OFF_TOP + graph_height)
              line(X_OFF_LEFT + graph_width, Y_OFF_TOP + graph_height)
              
              stroke 0x000000, thickness: 2, miter_limit: 10
            }
          
            # now create the fill for the graph below the graph line
            graph_path(graph_width, graph_height, true) {
              fill @histogram_color.merge(a: 0.5)
            }
            
            # now draw the histogram line
            graph_path(graph_width, graph_height, false) {
              stroke @histogram_color.merge(thickness: 2, miter_limit: 10)
            }
          end
        }
      }
    }.show
  end
end

Histogram.new.launch
