require_relative '../spec_helper'

RSpec.describe DocusignDtr::Document do
  subject { DocusignDtr::Document.new(client:) }
  let(:client) { double }
  let(:documents) { { 'documents' => [document] } }
  let(:document_file) { 'content_file' }
  let(:document) do
    {
      id: 99
    }
  end

  describe '#initialize' do
    it { expect(subject.client).to eq client }
    it { expect { DocusignDtr::Document.new }.to raise_error(StandardError) }
  end

  describe '#all_by_room_id' do
    it 'returns array of documents' do
      expect(client).to receive(:get).and_return(documents)
      expect(subject.all_by_room_id(document['room_id']).first).to be_a DocusignDtr::Models::Document
    end
  end

  describe '#find' do
    it 'returns one document object' do
      expect(client).to receive(:get).and_return(document)
      expect(subject.find(document['id'])).to be_a DocusignDtr::Models::Document
    end
  end

  describe '#create' do
    skip
  end

  describe '#destroy' do
    skip
  end

  describe '#download' do
    it 'downloads string content' do
      expect(client).to receive(:get).and_return(document_file)
      expect(subject.download(document['id'])).to be_a String
    end
  end

  describe '#update' do
    skip
  end
end
