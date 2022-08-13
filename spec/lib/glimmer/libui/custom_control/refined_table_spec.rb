require 'spec_helper'

require 'lib/glimmer/libui/custom_control/refined_table'

RSpec.describe Glimmer::LibUI::CustomControl::RefinedTable do
  describe 'FILTER_DEFAULT' do
    let(:row_hash) do
      {
        'First Name' => 'John',
        'Last Name' => 'Doe',
        'City' => 'Urbana-Champaign',
        'State' => 'Illinois',
        'Country' => 'USA'
      }
    end
    
    it 'matches one word' do
      query = 'Doe'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
    
    it 'matches multiple words by ANDing them' do
      query = 'Illinois Doe'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
    
    it 'matches multiple words surrounded by double-quotes as an exact term ' do
      query = '"John Doe"'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
    
    it 'does not match multiple words surrounded by double-quotes as an exact term ' do
      query = '"Doe John"'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_falsey
    end
  end
end
