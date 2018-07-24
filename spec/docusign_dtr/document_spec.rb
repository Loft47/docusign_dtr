require_relative '../spec_helper'

RSpec.describe DocusignDtr::Document do
  subject { DocusignDtr::Document.new(client: client) }
  let(:client) { double }
  let(:documents) { { 'documents' => [document] } }
  let(:document) do
    {
      room_id: 99
    }
  end

  describe '#initialize' do
    it { expect(subject.client).to eq client }
    it { expect { DocusignDtr::Document.new }.to raise_error(StandardError) }
  end

  describe '#all_by_room' do
    it 'returns array of documents' do
      expect(client).to receive(:get).and_return(documents)
      expect(subject.all_by_room(room_id: document['room_id']).first).to be_a DocusignDtr::Models::Document
    end
  end
end
