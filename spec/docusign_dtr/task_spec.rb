require_relative '../spec_helper'

RSpec.describe DocusignDtr::Task do
  subject { DocusignDtr::Task.new(client: client) }
  let(:client) { double }
  let(:tasks) { { 'tasks' => [task] } }
  let(:task) do
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
    it { expect { DocusignDtr::Task.new }.to raise_error(StandardError) }
  end

  describe '#all' do
    it 'returns array of member' do
      expect(client).to receive(:get).and_return(tasks)
      expect(subject.all.first).to be_a DocusignDtr::Models::Task
    end
  end
end
