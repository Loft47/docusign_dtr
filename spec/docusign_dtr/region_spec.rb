require_relative '../spec_helper'

RSpec.describe DocusignDtr::Region do
  subject { DocusignDtr::Region.new(client: client) }
  let(:client) { double }
  let(:regions) { { 'regions' => [region] } }
  let(:region) do
    {
      office_count: 0,
      manager_count: 0,
      agent_count: 0,
      id: 99,
      name: 'Region Name'
    }
  end

  describe '#initialize' do
    it { expect(subject.client).to eq client }
    it { expect { DocusignDtr::Region.new }.to raise_error(StandardError) }
  end

  describe '#all' do
    it 'returns array of regions' do
      expect(client).to receive(:get).and_return(regions)
      expect(subject.all.first).to be_a DocusignDtr::Models::Region
    end
  end
end
