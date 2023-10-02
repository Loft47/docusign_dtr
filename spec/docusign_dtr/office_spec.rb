require_relative '../spec_helper'

RSpec.describe DocusignDtr::Office do
  subject { DocusignDtr::Office.new(client:) }
  let(:client) { double }
  let(:offices) { { 'offices' => [office] } }
  let(:office) { { id: 88, office_name: 'My Office', address: nil, phone: '555-5555' } }

  describe '#initialize' do
    it { expect(subject.client).to eq client }
    it { expect { DocusignDtr::Office.new }.to raise_error(StandardError) }
  end

  describe '#all' do
    it 'returns array of offices' do
      expect(client).to receive(:get).and_return(offices)
      expect(subject.all.first).to be_a DocusignDtr::Models::Office
    end
  end
end
