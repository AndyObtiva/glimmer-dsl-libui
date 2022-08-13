require 'spec_helper'

require 'lib/glimmer/libui/custom_control/refined_table'

RSpec.describe Glimmer::LibUI::CustomControl::RefinedTable do
  describe 'FILTER_DEFAULT' do
    it 'matches one word' do
      text = 'John Doe Urbana Champaign Illinois USA'
      query = 'Doe'
      result = described_class::FILTER_DEFAULT.call(text, query)
      expect(result).to be_truthy
    end
    
    it 'matches multiple words by ANDing them' do
      text = 'John Doe Urbana Champaign Illinois USA'
      query = 'Illinois Doe'
      result = described_class::FILTER_DEFAULT.call(text, query)
      expect(result).to be_truthy
    end
  end
end
