require 'glimmer-dsl-libui'

class BasicScrollingArea
  include Glimmer
  
  SCROLLING_AREA_WIDTH = 800
  SCROLLING_AREA_HEIGHT = 400
  SCROLLING_AREA_PADDING_X = 20
  SCROLLING_AREA_PADDING_Y = 20
  
  def initialize
    @x = SCROLLING_AREA_PADDING_X
    @y = SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y
    create_gui
    Glimmer::LibUI.timer(0.01) do
      @x += SCROLLING_AREA_PADDING_X
      @y = [[@y + rand(SCROLLING_AREA_PADDING_Y*4)*(rand(2) == 0 ? -1 : 1), SCROLLING_AREA_PADDING_Y].max, SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y].min
      @graph.content { # re-open @graph's content and add a line
        line(@x, @y)
      }
      @scrolling_area.scroll_to(@x - (SCROLLING_AREA_WIDTH/2), @y)
      # return false to stop timer once @x exceeds scrolling area width - padding
      false if @x >= (SCROLLING_AREA_WIDTH - SCROLLING_AREA_PADDING_X*2)
    end
  end
  
  def launch
    @main_window.show
  end
  
  def x_axis
    polyline(SCROLLING_AREA_PADDING_X, SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y, SCROLLING_AREA_WIDTH - SCROLLING_AREA_PADDING_X*2, SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y) {
      stroke :black, thickness: 3
    }
    
    ((SCROLLING_AREA_WIDTH - SCROLLING_AREA_PADDING_X*4) / SCROLLING_AREA_PADDING_X).times do |x_multiplier|
      x = x_multiplier*SCROLLING_AREA_PADDING_X + SCROLLING_AREA_PADDING_X*2
      y = SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y
      
      polyline(x, y, x, y + SCROLLING_AREA_PADDING_Y/2) {
        stroke :black, thickness: 2
      }
    end
  end
  
  def y_axis
    polyline(SCROLLING_AREA_PADDING_X, SCROLLING_AREA_PADDING_Y, SCROLLING_AREA_PADDING_X, SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y) {
      stroke :black, thickness: 3
    }
    
    ((SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y*3) / SCROLLING_AREA_PADDING_Y).times do |y_multiplier|
      x = SCROLLING_AREA_PADDING_X
      y = y_multiplier*SCROLLING_AREA_PADDING_Y + SCROLLING_AREA_PADDING_Y*2
      
      polyline(x, y, x - SCROLLING_AREA_PADDING_X/2, y) {
        stroke :black, thickness: 2
      }
    end
  end
  
  def create_gui
    @main_window = window('Basic Scrolling Area', SCROLLING_AREA_WIDTH / 2, SCROLLING_AREA_HEIGHT) {
      resizable false
      
      @scrolling_area = scrolling_area(SCROLLING_AREA_WIDTH, SCROLLING_AREA_HEIGHT) {
        x_axis
        y_axis
        
        @graph = figure(SCROLLING_AREA_PADDING_X, SCROLLING_AREA_HEIGHT - SCROLLING_AREA_PADDING_Y) {
          stroke :blue, thickness: 2
        }
      }
    }
  end
end

BasicScrollingArea.new.launch
