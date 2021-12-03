require 'glimmer-dsl-libui'

class BasicTableColor
  Animal = Struct.new(:name, :sound, :mammal)
  
  class AnimalPresenter < Animal
    def name_color
      color = case name
      when 'cat'
        :red
      when 'dog'
        :yellow
      when 'chicken'
        :beige
      when 'horse'
        :purple
      when 'cow'
        :gray
      end
      [name, color]
    end
    
    def sound_color
      color = case name
      when 'cat', 'chicken', 'cow'
        :blue
      when 'dog', 'horse'
        {r: 240, g: 32, b: 32}
      end
      [sound, color]
    end
    
    def mammal_description_color
      color = case name
      when 'cat', 'dog', 'horse', 'cow'
        :green
      when 'chicken'
        :red
      end
      [mammal, 'mammal', color]
    end
    
    def image_description_color
      color = case name
      when 'cat', 'dog', 'horse'
        :dark_blue
      when 'chicken'
        :beige
      when 'cow'
        :brown
      end
      [img, 'Glimmer', color]
    end
    
    def img
      # scale image to 24x24 (can be passed as file path String only instead of Array to avoid scaling)
      [File.expand_path('../icons/glimmer.png', __dir__), 24, 24]
    end
    
    def background_color
      case name
      when 'cat'
        {r: 255, g: 120, b: 0, a: 0.5}
      when 'dog'
        :skyblue
      when 'chicken'
        {r: 5, g: 120, b: 110}
      when 'horse'
        '#13a1fb'
      when 'cow'
        0x12ff02
      end
    end
  end
  
  include Glimmer
  
  attr_accessor :animals
  
  def initialize
    @animals = [
      AnimalPresenter.new('cat', 'meow', true),
      AnimalPresenter.new('dog', 'woof', true),
      AnimalPresenter.new('chicken', 'cock-a-doodle-doo', false),
      AnimalPresenter.new('horse', 'neigh', true),
      AnimalPresenter.new('cow', 'moo', true),
    ]
  end
  
  def launch
    window('Animals', 500, 200) {
      horizontal_box {
        table {
          text_color_column('Animal')
          text_color_column('Sound')
          checkbox_text_color_column('Description')
          image_text_color_column('GUI')
          background_color_column # must always be the last column and always expects data-binding model attribute `background_color` when binding to Array of models
    
          cell_rows <= [self, :animals, column_attributes: {'Animal' => :name_color, 'Sound' => :sound_color, 'Description' => :mammal_description_color, 'GUI' => :image_description_color}]
        }
      }
    }.show
  end
end

BasicTableColor.new.launch
