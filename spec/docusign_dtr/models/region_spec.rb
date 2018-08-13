require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::Region do
  let(:client) { double }
  let(:attrs) do
    %i[agent_count id manager_count name office_count]
  end
  subject do
    region = DocusignDtr::Models::Region.new
    region.client = client
    region
  end

  describe '#attributes' do
    it { expect(subject.attributes.keys).to eq(attrs) }
  end
end
