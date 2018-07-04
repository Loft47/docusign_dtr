require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::Room do
  let(:client) { double }
  let(:address) { DocusignDtr::Models::Address.new }
  subject do
    room = DocusignDtr::Models::Room.new(
      room_id: 99,
      room_name: 'Main Office',
      mls_id: '123456789',
      address: address,
      owners: {},
      office_id: 2,
      latitude: 0,
      longitude: 0,
      closed_status_id: '',
      created_date: '2018-06-26T21:15:28.663',
      is_under_contract: false,
      status: 'Active'
    )
    room.client = client
    room
  end

  describe '#attributes' do
    it 'has them' do
      expect(subject).to have_attributes(
        room_id: 99,
        room_name: 'Main Office',
        mls_id: '123456789',
        address: address,
        owners: {},
        office_id: 2,
        latitude: 0,
        longitude: 0,
        closed_status_id: '',
        created_date: '2018-06-26T21:15:28.663',
        is_under_contract: false,
        status: 'Active'
      )
    end
  end
end
