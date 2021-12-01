require 'glimmer-dsl-libui'

class BasicTableButton
  BasicAnimal = Struct.new(:name, :sound)
  
  class Animal < BasicAnimal
    def action
      'delete'
    end
  end
  
  include Glimmer
  
  attr_accessor :animals
  
  def initialize
    @animals = [
      Animal.new('cat', 'meow'),
      Animal.new('dog', 'woof'),
      Animal.new('chicken', 'cock-a-doodle-doo'),
      Animal.new('horse', 'neigh'),
      Animal.new('cow', 'moo'),
    ]
  end
  
  def launch
    window('Animal sounds', 400, 200) {
      horizontal_box {
        table {
          text_column('Animal')
          text_column('Description')
          button_column('Action') {
            on_clicked do |row|
              # Option 1: direct data deletion is the simpler solution
#               @animals.delete_at(row) # automatically deletes actual table row due to explicit data-binding
              
              # Option 2: cloning only to demonstrate table row deletion upon explicit setting of animals attribute (cloning is not recommended beyond demonstrating this point)
              new_animals = @animals.clone
              new_animals.delete_at(row)
              self.animals = new_animals # automatically loses deleted table row due to explicit data-binding
            end
          }
    
          
          cell_rows <= [self, :animals, column_attributes: {'Animal' => :name, 'Description' => :sound}]
          
          # explicit unidirectional data-binding of table cell_rows to self.animals
          on_changed do |row, type, row_data|
            puts "Row #{row} #{type}: #{row_data}"
            $stdout.flush
          end
        }
      }
    }.show
  end
end

BasicTableButton.new.launch
