require_relative '../spec_helper'

RSpec.describe DocusignDtr::Meta do
  subject { DocusignDtr::Meta.new(client: client) }
  let(:client) { double }
  let(:metas) { { 'metas' => [meta] } }
  let(:meta) do
    {
      room_id: 99,
      room_name: 'Test Room',
      mls_id: '12345',
      address: nil,
      office_id: '1234',
      latitude: '-123',
      longitude: '49'
    }
  end

  describe '#initialize' do
    it { expect(subject.client).to eq client }
    it { expect { DocusignDtr::Meta.new }.to raise_error(StandardError) }
  end

  describe '#all' do
    it 'returns array of member' do
      expect(client).to receive(:get).and_return(metas)
      expect(subject.all.first).to be_a DocusignDtr::Models::Meta
    end
  end
end
