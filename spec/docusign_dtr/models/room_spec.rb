require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::Room do
  let(:client) { double }
  let(:address) { DocusignDtr::Models::Address.new }
  let(:task_lists) { [task_list] }
  let(:users_attrs) { { 'users' => [user_attr] } }
  let(:user_attr) do
    {
      user_id: 121_691,
      company_name: '',
      first_name: 'Robinson',
      last_name: 'Cruzoe',
      email: 'email@gmail.ca',
      role_id: 'buyer',
      transaction_side_id: 'listbuy',
      document_count: 0,
      is_registered: true,
      is_owner: false,
      role_name: 'Buyer',
      is_virtual_room_member: false
    }
  end
  let(:task_list) do
    {
      id: 73_999,
      name: 'Do something please',
      roomId: 81_742,
      canRemove: true,
      isGeneral: false,
      reviewStatus: 'CanReview',
      status: 'Open',
      taskListTemplateId: 5_855
    }
  end
  subject do
    room = DocusignDtr::Models::Room.new(
      address: DocusignDtr::Models::Address.new,
      auction_details: DocusignDtr::Models::AuctionDetail.new,
      closed_status_id: 1234,
      company_room_status_id: 1234,
      contract_amount: 2_000,
      created_date: '2018-06-26T21:15:28.663',
      creation_details: DocusignDtr::Models::CreationDetail.new,
      details: DocusignDtr::Models::RoomDetail.new,
      integrator_data: {},
      is_under_contract: false,
      last_updated_date: '2018-07-06T21:15:28.663',
      latitude: 49.17,
      lone_wolf_details: DocusignDtr::Models::LoneWolfDetail.new,
      longitude: -123.77,
      mls_id: '123456789',
      office_id: 2,
      owners: [DocusignDtr::Models::Owner.new],
      room_id: 99,
      room_image_url: 'http://www.google.ca',
      room_name: 'Main Office',
      status: 'Active',
      view_link: 'http://www.google.ca'
    )
    room.client = client
    room
  end

  describe '#attributes' do
    it 'has them' do
      expect(subject).to have_attributes(
        address: be_a(DocusignDtr::Models::Address),
        auction_details: be_a(DocusignDtr::Models::AuctionDetail),
        closed_status_id: 1234,
        company_room_status_id: 1234,
        contract_amount: 2_000,
        created_date: '2018-06-26T21:15:28.663',
        creation_details: be_a(DocusignDtr::Models::CreationDetail),
        details: be_a(DocusignDtr::Models::RoomDetail),
        integrator_data: {},
        is_under_contract: false,
        last_updated_date: '2018-07-06T21:15:28.663',
        latitude: 49.17,
        lone_wolf_details: be_a(DocusignDtr::Models::LoneWolfDetail),
        longitude: -123.77,
        mls_id: '123456789',
        office_id: 2,
        owners: be_a(Array),
        room_id: 99,
        room_image_url: 'http://www.google.ca',
        room_name: 'Main Office',
        status: 'Active',
        view_link: 'http://www.google.ca'
      )
    end
  end

  describe '#methods' do
    let(:documents) { { 'documents' => [document] } }
    let(:document) do
      {
        id: 11,
        room_id: 99
      }
    end

    it '#documents' do
      expect(client).to receive(:get).and_return(documents)
      expect(subject.documents.first).to be_a DocusignDtr::Models::Document
    end

    it '#task_lists' do
      expect(client).to receive(:get).and_return(task_lists)
      expect(subject.task_lists.first).to be_a DocusignDtr::Models::TaskList
    end

    it '#users' do
      expect(client).to receive(:get).and_return(users_attrs)
      expect(subject.users.first).to be_a DocusignDtr::Models::User
    end
  end
end
