require 'glimmer-dsl-libui'

class PaginatedRefinedTable
  Contact = Struct.new(:name, :email, :phone, :city, :state)
  
  include Glimmer::LibUI::Application
  
  NAMES_FIRST = %w[
    Liam Noah William James Oliver Benjamin Elijah Lucas Mason Logan Alexander Ethan Jacob Michael Daniel Henry Jackson Sebastian
    Aiden Matthew Samuel David Joseph Carter Owen Wyatt John Jack Luke Jayden Dylan Grayson Levi Isaac Gabriel Julian Mateo
    Anthony Jaxon Lincoln Joshua Christopher Andrew Theodore Caleb Ryan Asher Nathan Thomas Leo Isaiah Charles Josiah Hudson
    Christian Hunter Connor Eli Ezra Aaron Landon Adrian Jonathan Nolan Jeremiah Easton Elias Colton Cameron Carson Robert Angel
    Maverick Nicholas Dominic Jaxson Greyson Adam Ian Austin Santiago Jordan Cooper Brayden Roman Evan Ezekiel Xaviar Jose Jace
    Jameson Leonardo Axel Everett Kayden Miles Sawyer Jason Emma Olivia Bartholomew Corey Danielle Eva Felicity
  ]
  
  NAMES_LAST = %w[
    Smith Johnson Williams Brown Jones Miller Davis Wilson Anderson Taylor George Harrington Iverson Jackson Korby Levinson
  ]
  
  CITIES = [
    'Bellesville', 'Lombardia', 'Steepleton', 'Deerenstein', 'Schwartz', 'Hollandia', 'Saint Pete', 'Grandville', 'London',
    'Berlin', 'Elktown', 'Paris', 'Garrison', 'Muncy', 'St Louis',
  ]
  
  STATES = [ 'AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA',
             'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME',
             'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM',
             'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX',
             'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY']
             
  attr_accessor :contacts, :name, :email, :phone, :city, :state, :filter_value, :index
  
  before_body do
    @contacts = 50_000.times.map do |n|
      n += 1
      first_name = NAMES_FIRST.sample
      last_name = NAMES_LAST.sample
      city = CITIES.sample
      state = STATES.sample
      Contact.new("#{first_name} #{last_name}", "#{first_name.downcase}#{n}@#{last_name.downcase}.com", '555-555-5555', city, state)
    end
  end
  
  body {
    window("50,000 Paginated Contacts", 600, 700) {
      margined true
      
      vertical_box {
        form {
          stretchy false
          
          entry {
            label 'Name'
            text <=> [self, :name] # bidirectional data-binding between entry text and self.name
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
            if new_row.map(&:to_s).include?('')
              msg_box_error('Validation Error!', 'All fields are required! Please make sure to enter a value for all fields.')
            else
              @contacts << Contact.new(*new_row) # automatically inserts a row into the table due to explicit data-binding
              @unfiltered_contacts = @contacts.dup
              self.name = '' # automatically clears name entry through explicit data-binding
              self.email = ''
              self.phone = ''
              self.city = ''
              self.state = ''
            end
          end
        }
        
        refined_table(
          model_array: contacts,
          table_columns: {
            'Name'  => {text: {editable: false}},
            'Email' => :text,
            'Phone' => :text,
            'City'  => :text,
            'State' => :text,
          },
          table_editable: true,
          per_page: 20,
          # page: 1, # initial page is 1
          # visible_page_count: true, # page count can be hidden if preferred
        )
      }
    }
  }
end

PaginatedRefinedTable.launch
