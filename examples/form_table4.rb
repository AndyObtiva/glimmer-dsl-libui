require 'glimmer-dsl-libui'

class FormTable
  include Glimmer
  
  attr_accessor :data
  
  def initialize
    @data = [
      ['Lisa Sky', 'lisa@sky.com', '720-523-4329', 'Denver', 'CO'],
      ['Jordan Biggins', 'jordan@biggins.com', '617-528-5399', 'Boston', 'MA'],
      ['Mary Glass', 'mary@glass.com', '847-589-8788', 'Elk Grove Village', 'IL'],
      ['Darren McGrath', 'darren@mcgrath.com', '206-539-9283', 'Seattle', 'WA'],
      ['Melody Hanheimer', 'melody@hanheimer.com', '213-493-8274', 'Los Angeles', 'CA'],
    ]
  end
  
  def launch
    window('Contacts', 600, 600) { |w|
      margined true
      
      vertical_box {
        form {
          stretchy false
          
          @name_entry = entry {
            label 'Name'
          }
          
          @email_entry = entry {
            label 'Email'
          }
          
          @phone_entry = entry {
            label 'Phone'
          }
          
          @city_entry = entry {
            label 'City'
          }
          
          @state_entry = entry {
            label 'State'
          }
        }
        
        button('Save Contact') {
          stretchy false
          
          on_clicked do
            new_row = [@name_entry.text, @email_entry.text, @phone_entry.text, @city_entry.text, @state_entry.text]
            if new_row.include?('')
              msg_box_error(w, 'Validation Error!', 'All fields are required! Please make sure to enter a value for all fields.')
            else
              data << new_row # automatically inserts a row into the table due to implicit data-binding
              @unfiltered_data = data.dup
              @name_entry.text = ''
              @email_entry.text = ''
              @phone_entry.text = ''
              @city_entry.text = ''
              @state_entry.text = ''
            end
          end
        }
        
        search_entry { |se|
          stretchy false
          
          on_changed do
            filter_value = se.text
            @unfiltered_data ||= data.dup
            # Unfilter first to remove any previous filters
            data.replace(@unfiltered_data) # affects table indirectly through implicit data-binding
            # Now, apply filter if entered
            unless filter_value.empty?
              data.filter! do |row_data| # affects table indirectly through implicit data-binding
                row_data.any? do |cell|
                  cell.to_s.downcase.include?(filter_value.downcase)
                end
              end
            end
          end
        }
        
        table {
          text_column('Name')
          text_column('Email')
          text_column('Phone')
          text_column('City')
          text_column('State')
    
          cell_rows <=> [self, :data] # explicit data-binding to raw data Array of Arrays
          
          on_changed do |row, type, row_data|
            puts "Row #{row} #{type}: #{row_data}"
          end
        }
      }
    }.show
  end
end

FormTable.new.launch
