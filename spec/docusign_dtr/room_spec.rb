require_relative '../spec_helper'

RSpec.describe DocusignDtr::Room do
  subject { DocusignDtr::Room.new(client: client) }
  let(:client) { double }
  let(:rooms) { { 'rooms' => [room] } }
  let(:room) do
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
    it { expect { DocusignDtr::Room.new }.to raise_error(StandardError) }
  end

  describe '#all' do
    it 'returns array of rooms' do
      expect(client).to receive(:get).and_return(rooms)
      expect(subject.all.first).to be_a DocusignDtr::Models::Room
    end
  end
end
