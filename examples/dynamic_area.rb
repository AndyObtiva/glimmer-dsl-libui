require 'glimmer-dsl-libui'

class DynamicArea
  include Glimmer
  
  attr_accessor :rectangle_x, :rectangle_y, :rectangle_width, :rectangle_height, :rectangle_red, :rectangle_green, :rectangle_blue, :rectangle_alpha
  
  def initialize
    @rectangle_x = 25
    @rectangle_y = 25
    @rectangle_width = 150
    @rectangle_height = 150
    @rectangle_red = 102
    @rectangle_green = 102
    @rectangle_blue = 204
    @rectangle_alpha = 100
  end
  
  def launch
    window('Dynamic Area', 240, 600) {
      margined true
      
      vertical_box {
        label('Rectangle Properties') {
          stretchy false
        }
        
        form {
          stretchy false
          
          spinbox(0, 1000) {
            label 'x'
            value <=> [self, :rectangle_x, after_write: -> {@area.queue_redraw_all}]
          }
          
          spinbox(0, 1000) {
            label 'y'
            value <=> [self, :rectangle_y, after_write: -> {@area.queue_redraw_all}]
          }
          
          spinbox(0, 1000) {
            label 'width'
            value <=> [self, :rectangle_width, after_write: -> {@area.queue_redraw_all}]
          }
          
          spinbox(0, 1000) {
            label 'height'
            value <=> [self, :rectangle_height, after_write: -> {@area.queue_redraw_all}]
          }
          
          spinbox(0, 255) {
            label 'red'
            value <=> [self, :rectangle_red, after_write: -> {@area.queue_redraw_all}]
          }
          
          spinbox(0, 255) {
            label 'green'
            value <=> [self, :rectangle_green, after_write: -> {@area.queue_redraw_all}]
          }
          
          spinbox(0, 255) {
            label 'blue'
            value <=> [self, :rectangle_blue, after_write: -> {@area.queue_redraw_all}]
          }
          
          spinbox(0, 100) {
            label 'alpha'
            value <=> [self, :rectangle_alpha, after_write: -> {@area.queue_redraw_all}]
          }
        }
        
        @area = area {
          on_draw do |area_draw_params|
            rectangle(rectangle_x, rectangle_y, rectangle_width, rectangle_height) { # a dynamic path is added semi-declaratively inside on_draw block
              fill r: rectangle_red, g: rectangle_green, b: rectangle_blue, a: rectangle_alpha / 100.0
            }
          end
        }
      }
    }.show
  end
end

DynamicArea.new.launch
