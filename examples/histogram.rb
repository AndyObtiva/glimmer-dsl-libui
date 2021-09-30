# https://github.com/jamescook/libui-ruby/blob/master/example/histogram.rb

require 'glimmer-dsl-libui'

include Glimmer

X_OFF_LEFT   = 20
Y_OFF_TOP    = 20
X_OFF_RIGHT  = 20
Y_OFF_BOTTOM = 20
POINT_RADIUS = 5

blue         = 0x1E90FF

def graph_size(area_width, area_height)
  graph_width = area_width - X_OFF_LEFT - X_OFF_RIGHT
  graph_height = area_height - Y_OFF_TOP - Y_OFF_BOTTOM
  [graph_width, graph_height]
end

# matrix = UI::FFI::DrawMatrix.malloc

def point_locations(datapoints, width, height)
  xincr = width / 9.0 # 10 - 1 to make the last point be at the end
  yincr = height / 100.0

  data = []
  datapoints.each_with_index do |dp, i|
    val = 100 - dp.value
    data << [xincr * i, yincr * val]
    i += 1
  end

  data
end

def construct_graph(area_draw_params, datapoints, width, height, should_extend, &block)
  locations = point_locations(datapoints, width, height)
  path(area_draw_params) {
    first_location = locations[0] # x and y
    figure(first_location[0], first_location[1]) {
      locations.each do |loc|
        line(loc[0], loc[1])
      end
      if should_extend
        line(width, height)
        line(0, height)
        
        closed true
      end
    }
    
    block.call
  }
end

def hex_to_rgb(color)
  {
    r: ((color >> 16) & 0xFF),
    g: ((color >> 8) & 0xFF),
    b: (color & 0xFF),
    a: 1.0
  }
end

window('histogram example', 640, 480) {
  margined true
  
  horizontal_box {
    vertical_box {
      stretchy false
      
      @datapoints = 10.times.map do
        spinbox(0, 100) { |datapoint|
          stretchy false
          value Random.new.rand(90)
          
          on_changed do
            @area.queue_redraw_all
          end
        }
      end
      
      @color_button = color_button {
        stretchy false
        color hex_to_rgb(blue)
        
        on_changed do
          @area.queue_redraw_all
        end
      }
    }
    
    @area = area {
      on_draw do |area_draw_params|
        path(area_draw_params) {
          rectangle(0, 0, area_draw_params[:area_width], area_draw_params[:area_height])
          
          fill hex_to_rgb(0xFFFFFF)
        }
        
        graph_width, graph_height = *graph_size(area_draw_params[:area_width], area_draw_params[:area_height])
      
        path(area_draw_params) {
          figure(X_OFF_LEFT, Y_OFF_TOP) {
            line(X_OFF_LEFT, Y_OFF_TOP + graph_height)
            line(X_OFF_LEFT + graph_width, Y_OFF_TOP + graph_height)
          }
          
          stroke hex_to_rgb(0x000000).merge(thickness: 2, miter_limit: 10)
        }
      
        # now transform the coordinate space so (0, 0) is the top-left corner of the graph
#         UI.draw_matrix_set_identity(matrix)
#         UI.draw_matrix_translate(matrix, X_OFF_LEFT, Y_OFF_TOP)
#         UI.draw_transform(area_draw_params.Context, matrix)
      
        # now create the fill for the graph below the graph line
        path = construct_graph(area_draw_params, @datapoints, graph_width, graph_height, true) {
          fill @color_button.color.merge(a: 0.5)
        }
        
        # now draw the histogram line
        path = construct_graph(area_draw_params, @datapoints, graph_width, graph_height, false) {
          stroke @color_button.color.merge(thickness: 2, miter_limit: 10)
        }
      end
    }
  }
}.show
