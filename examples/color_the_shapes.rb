require 'glimmer-dsl-libui'

class ColorTheShapes
  include Glimmer
  
  WINDOW_WIDTH = 800
  WINDOW_HEIGHT = 600
  SHAPE_MIN_SIZE = 15
  SHAPE_MAX_SIZE = 100
  MARGIN_WIDTH = 55
  MARGIN_HEIGHT = 155
  TIME_MAX_EASY = 4
  TIME_MAX_MEDIUM = 3
  TIME_MAX_HARD = 2
  TIME_MAX_INSANE = 1
  SHAPES = ['square'] + (OS.windows? ? [] : ['circle'])
  
  attr_accessor :score
  
  def initialize
    @shapes_data = []
    @score = 0
    @time_max = TIME_MAX_HARD
    @game_over = false
    register_observers
    setup_shape_factory
  end
  
  def register_observers
    observer = Glimmer::DataBinding::Observer.proc do |new_score|
      @score_label.text = new_score.to_s
      if new_score == -20
        @game_over = true
        msg_box('You Lost!', 'Sorry! Your score reached -20')
        restart_game
      elsif new_score == 0
        @game_over = true
        msg_box('You Won!', 'Congratulations! Your score reached 0')
        restart_game
      end
    end
    observer.observe(self, :score) # automatically enhances self to become Glimmer::DataBinding::ObservableModel and notify observer on score attribute changes
  end
  
  def setup_shape_factory
    consumer = Proc.new do
      unless @game_over
        if @shapes_data.empty?
          # start with 3 shapes to make more challenging
          add_shape until @shapes_data.size > 3
        else
          add_shape
        end
      end
      delay = rand * @time_max
      Glimmer::LibUI.timer(delay, repeat: false, &consumer)
    end
    Glimmer::LibUI.queue_main(&consumer)
  end
  
  def add_shape
    shape_x = rand * (WINDOW_WIDTH - MARGIN_WIDTH - SHAPE_MAX_SIZE) + SHAPE_MAX_SIZE
    shape_y = rand * (WINDOW_HEIGHT - MARGIN_HEIGHT - SHAPE_MAX_SIZE) + SHAPE_MAX_SIZE
    shape_size = rand * (SHAPE_MAX_SIZE - SHAPE_MIN_SIZE) + SHAPE_MIN_SIZE
    stroke_color = Glimmer::LibUI.x11_colors.sample
    @shapes_data << {
      args: [shape_x, shape_y, shape_size],
      fill: nil,
      stroke: stroke_color
    }
    @area.queue_redraw_all
    self.score -= 1 # notifies score observers automatically of change
  end
  
  def restart_game
    @score = 0 # update variable directly to avoid notifying observers
    @shapes_data.clear
    @game_over = false
  end
  
  def color_shape(x, y)
    clicked_shape_data = @shapes_data.find do |shape_data|
      shape_data[:fill].nil? && shape_data[:shape]&.include?(x, y)
    end
    if clicked_shape_data
      clicked_shape_data[:fill] = clicked_shape_data[:stroke]
      push_colored_shape_behind_uncolored_shapes(clicked_shape_data)
      @area.queue_redraw_all
      self.score += 1 # notifies score observers automatically of change
    end
  end
  
  def push_colored_shape_behind_uncolored_shapes(colored_shape_data)
    removed_colored_shape_data = @shapes_data.delete(colored_shape_data)
    last_colored_shape_data = @shapes_data.select {|cd| cd[:fill]}.last
    last_colored_shape_data_index = @shapes_data.index(last_colored_shape_data) || -1
    @shapes_data.insert(last_colored_shape_data_index + 1, removed_colored_shape_data)
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
          msg_box('Instructions', "Score goes down as shapes are added.\nIf it reaches -20, you lose!\n\nClick shapes to color and score!\nOnce score reaches 0, you win!\n\nBeware of concealed light-colored shapes!\nThey are revealed once darker shapes intersect them.\n\nThere are four levels of difficulty.\nChange via difficulty menu if the game gets too tough.")
        end
      }
    }
    
    window('Color The Shapes', WINDOW_WIDTH, WINDOW_HEIGHT) {
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
        
        label('Score goes down as shapes are added. If it reaches -20, you lose!') {
          left 0
          top 1
          halign :center
        }
        
        label('Click shapes to color and score! Once score reaches 0, you win!') {
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
          hexpand true
          vexpand true
          halign :fill
          valign :fill

          on_draw do |area_draw_params|
            path {
              rectangle(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)

              fill :white
            }

            @shapes_data.each do |shape_data|
              path {
                shape_data[:shape] = send(SHAPES.sample, *shape_data[:args])

                fill shape_data[:fill]
                stroke shape_data[:stroke]
              }
            end
          end

          on_mouse_down do |area_mouse_event|
            color_shape(area_mouse_event[:x], area_mouse_event[:y])
          end
        }
      }
    }.show
  end
end

ColorTheShapes.new.launch
