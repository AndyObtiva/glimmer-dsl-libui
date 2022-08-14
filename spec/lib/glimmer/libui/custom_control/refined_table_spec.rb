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
    
    it 'matches a specific column by first few letters of column name' do
      query = 'last:doe' # last name
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
    
    it 'does not match a specific column by by first few letters of column name' do
      query = 'first:Doe' # first name
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_falsey
    end
    
    it 'matches a specific column by first letter of column name' do
      query = 'l:doe' # last name
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
    
    it 'does not match a specific column by by first letter of column name' do
      query = 'f:Doe' # first name
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_falsey
    end
    
    it 'does not match a specific column by middle letter of column name' do
      query = 'n:john' # attempting to match first name with n
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_falsey
    end
    
    it 'matches first specific column in multiple having first letter of column name' do
      query = 'c:champaign' # city
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
    
    it 'does not match first specific column in multiple having first letter of column name' do
      query = 'c:chicago' # city
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_falsey
    end
    
    it 'matches a specific column by full double-quoted human column name' do
      query = '"last name":doe'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
    
    it 'does not match a specific column by full double-quoted human column name' do
      query = '"first name":Doe'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_falsey
    end
    
    it 'matches a specific column by full underscored column name and double-quoted column value' do
      query = 'first_name:"jo n"'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
    
    it 'does not match a specific column by full underscored column name and double-quoted column value' do
      query = 'first_name:"jo e"'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_falsey
    end
    
    it 'matches a specific column by full double-quoted column name and double-quoted column value' do
      query = '"first name":"jo n"'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
    
    it 'does not match a specific column by full double-quoted column name and double-quoted column value' do
      query = '"first name":"jo e"'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_falsey
    end
    
    it 'matches a double-quoted column-specific term, multiple words, a double-quoted term' do
      query = ' "First Name":Jo Doe Illinois "a-Champ" '
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
    
    it 'matches multiple words, a double-quoted term, and a column-specific term' do
      query = 'Doe Illinois "a-Champ" First_name:Jo'
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
    
    it 'matches column-specifc term without value, treating value as empty string' do
      query = 'first_name:'
      result = described_class::FILTER_DEFAULT.call(row_hash, query)
      expect(result).to be_truthy
    end
  end
end
