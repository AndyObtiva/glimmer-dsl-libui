require 'glimmer-dsl-libui'

class FormTable
  include Glimmer
  
  attr_accessor :name, :email, :phone, :city, :state, :filter_value
  
  def initialize
    @data = [
      ['Lisa Sky', 'lisa@sky.com', '720-523-4329', 'Denver', 'CO', '80014'],
      ['Jordan Biggins', 'jordan@biggins.com', '617-528-5399', 'Boston', 'MA', '02101'],
      ['Mary Glass', 'mary@glass.com', '847-589-8788', 'Elk Grove Village', 'IL', '60007'],
      ['Darren McGrath', 'darren@mcgrath.com', '206-539-9283', 'Seattle', 'WA', '98101'],
      ['Melody Hanheimer', 'melody@hanheimer.com', '213-493-8274', 'Los Angeles', 'CA', '90001'],
    ]
  end
  
  def launch
    window('Contacts', 600, 600) { |w|
      margined true
      
      vertical_box {
        form {
          stretchy false
          
          entry {
            label 'Name'
            text <=> [self, :name]
          }
          
          entry {
            label 'Email'
            text <=> [self, :email]
          }
          
          entry {
            label 'Phone'
            text <=> [self, :phone]
          }
          
          entry {
            label 'City'
            text <=> [self, :city]
          }
          
          entry {
            label 'State'
            text <=> [self, :state]
          }
        }
        
        button('Save Contact') {
          stretchy false
          
          on_clicked do
            new_row = [name, email, phone, city, state]
            if new_row.include?('')
              msg_box_error(w, 'Validation Error!', 'All fields are required! Please make sure to enter a value for all fields.')
            else
              @data << new_row # automatically inserts a row into the table due to implicit data-binding
              @unfiltered_data = @data.dup
              self.name = '' # automatically clears name entry through explicit data-binding
              self.email = ''
              self.phone = ''
              self.city = ''
              self.state = ''
            end
          end
        }
        
        search_entry {
          stretchy false
          text <=> [self, :filter_value, # bidirectional data-binding of text to self.filter_value with after_write option
            after_write: ->(filter_value) { # execute after write to self.filter_value
              @unfiltered_data ||= @data.dup
              # Unfilter first to remove any previous filters
              @data.replace(@unfiltered_data) # affects table indirectly through implicit data-binding
              # Now, apply filter if entered
              unless filter_value.empty?
                @data.filter! do |row_data| # affects table indirectly through implicit data-binding
                  row_data.any? do |cell|
                    cell.to_s.downcase.include?(filter_value.downcase)
                  end
                end
              end
            }
          ]
        }
        
        table {
          text_column('Name')
          text_column('Email')
          text_column('Phone')
          text_column('City')
          text_column('State')
    
          cell_rows @data # implicit data-binding
          
          on_changed do |row, type, row_data|
            puts "Row #{row} #{type}: #{row_data}"
          end
        }
      }
    }.show
  end
end

FormTable.new.launch
