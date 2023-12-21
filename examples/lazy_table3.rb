require 'glimmer-dsl-libui'

class LazyTable
  Contact = Struct.new(:name, :email, :phone, :city, :state)
  
  # Extending Enumerator::Lazy enables building a collection generator in an encapsulated maintainable fashion
  class ContactGenerator < Enumerator::Lazy
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
                 
    def initialize(contact_count)
      # Make sure to pass super constructor size (2nd) argument as it gets used by Glimmer DSL for LibUI
      # to determine the number of rows in the table before generating all its data
      super(contact_count.times, contact_count) do |yielder, index|
        # Data will get lazy loaded into the table as the user scrolls through.
        # After data is built, it is cached long-term, till updating table `cell_rows`.
        yielder << contact_for(index)
      end
    end
    
    def contact_for(index)
      number = index + 1
      first_name = NAMES_FIRST.sample
      last_name = NAMES_LAST.sample
      phone = 10.times.map { rand(10) }.yield_self { |numbers| [numbers[0..2], numbers[3..5], numbers[6..9]].map(&:join).join('-') }
      city = CITIES.sample
      state = STATES.sample
      Contact.new("#{first_name} #{last_name}", "#{first_name.downcase}#{number}@#{last_name.downcase}.com", phone, city, state)
    end
  end
  
  include Glimmer::LibUI::Application

  body {
    window("1,000,000 Lazy Loaded Contacts", 600, 700) {
      margined true
      
      table {
        text_column('Name')
        text_column('Email')
        text_column('Phone')
        text_column('City')
        text_column('State')
        
        cell_rows ContactGenerator.new(1_000_000)
      }
    }
  }
end

LazyTable.launch
