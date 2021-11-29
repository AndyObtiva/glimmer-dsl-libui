# frozen_string_literal: true

require 'glimmer-dsl-libui'

class BasicTableButton
  include Glimmer
  
  attr_accessor :data
  
  def initialize
    @data = [
      %w[cat meow delete],
      %w[dog woof delete],
      %w[chicken cock-a-doodle-doo delete],
      %w[horse neigh delete],
      %w[cow moo delete]
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
#               @data.delete_at(row) # automatically deletes actual table row due to explicit data-binding
              
              # Option 2: cloning only to demonstrate table row deletion upon explicit setting of data attribute (cloning is not recommended beyond demonstrating this point)
              new_data = @data.clone
              new_data.delete_at(row)
              self.data = new_data # automatically loses deleted table row due to explicit data-binding
            end
          }
    
          cell_rows <=> [self, :data] # explicit data-binding of table cell_rows to self.data
          
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
