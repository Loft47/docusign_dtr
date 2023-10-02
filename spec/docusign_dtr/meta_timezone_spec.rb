require_relative '../spec_helper'

RSpec.describe DocusignDtr::MetaTimezone do
  subject { DocusignDtr::MetaTimezone.new(client:) }
  let(:client) { double }
  let(:metas) { { 'entities' => [meta] } }
  let(:meta) do
    {
      id: 'string',
      name: 'Meta Test',
      display_order: 0
    }
  end

  describe '#initialize' do
    it { expect(subject.client).to eq client }
    it { expect { DocusignDtr::MetaTimezone.new }.to raise_error(StandardError) }
  end

  describe '#all' do
    it 'returns array of elements' do
      expect(client).to receive(:get).and_return(metas)
      expect(subject.all.first).to be_a DocusignDtr::Models::MetaTimezone
    end
  end
end
