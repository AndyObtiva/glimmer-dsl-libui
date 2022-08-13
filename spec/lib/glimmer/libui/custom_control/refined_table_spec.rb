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
      query = 'doe'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
    
    it 'matches multiple words by ANDing them' do
      query = 'ILLINOIS doe'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
    
    it 'matches multiple words surrounded by double-quotes as an exact term ' do
      query = '"john doe"'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
    
    it 'does not match multiple words surrounded by double-quotes as an exact term ' do
      query = '"doe john"'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_falsey
    end
    
    it 'matches a specific column by full underscored column name' do
      query = 'last_name:doe'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
    
    it 'does not match a specific column by full underscored column name' do
      query = 'first_name:Doe'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_falsey
    end
    
    it 'matches multiple words, a double-quoted term, and a column-specific term' do
      query = 'First_name:Jo Doe Illinois "a-Champ"'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
    
    it 'fails to match multiple incorrect words, a double-quoted term, and a column-specific term' do
      query = 'First_name:Jo Does Illinoise "a-Champ"'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_falsey
    end
    
    it 'fails to match multiple words, an incorrect double-quoted term, and a column-specific term' do
      query = 'First_name:Jo Doe Illinois "b-Champ"'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_falsey
    end
    
    it 'fails to match multiple words, a double-quoted term, and an incorrect column-specific term' do
      query = 'First_name:Jos Doe Illinois "a-Champ"'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_falsey
    end
  end
end
