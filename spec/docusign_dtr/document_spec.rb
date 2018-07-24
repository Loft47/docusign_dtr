require_relative '../spec_helper'

RSpec.describe DocusignDtr::Document do
  subject { DocusignDtr::Document.new(client: client) }
  let(:client) { double }
  let(:documents) { { 'documents' => [document] } }
  let(:document) do
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
    it { expect { DocusignDtr::Document.new }.to raise_error(StandardError) }
  end

  describe '#all' do
    it 'returns array of documents' do
      expect(client).to receive(:get).and_return(documents)
      expect(subject.all.first).to be_a DocusignDtr::Models::Document
    end
  end
end
