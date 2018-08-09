require_relative '../spec_helper'

RSpec.describe DocusignDtr::Title do
  subject { DocusignDtr::Title.new(client: client) }
  let(:client) { double }
  let(:titles) { [title] }
  let(:title) do
    {
      id: 99,
      title: 'Administrator',
      member_count: 0
    }
  end

  describe '#initialize' do
    it { expect(subject.client).to eq client }
    it { expect { DocusignDtr::Title.new }.to raise_error(StandardError) }
  end

  describe '#all' do
    it 'returns array of title' do
      expect(client).to receive(:get).and_return(titles)
      expect(subject.all.first).to be_a DocusignDtr::Models::Title
    end
  end
end
