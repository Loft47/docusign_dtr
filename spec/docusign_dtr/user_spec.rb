require_relative '../spec_helper'

RSpec.describe DocusignDtr::User do
  subject { DocusignDtr::User.new(client: client) }
  let(:client) { double }
  let(:users) { { 'users' => [user] } }
  let(:user_info) do
    {
      user_id: 0,
      email: 'string',
      is_linked_to_account_server: true
    }
  end
  let(:user) do
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
  let(:profile_attrs) do
    {
      user_id: 99,
      email: 'string',
      is_linked_to_account_server: true
    }
  end

  describe '#initialize' do
    it { expect(subject.client).to eq client }
    it { expect { DocusignDtr::User.new }.to raise_error(StandardError) }
  end

  describe '#user_info' do
    it 'returns the logged user info' do
      expect(client).to receive(:get).and_return(user_info)
      expect(subject.user_info).to be_a DocusignDtr::Models::User
    end
  end

  describe '#profile' do
    it "returns the user's profile attributes" do
      expect(client).to receive(:get).and_return(profile_attrs)
      expect(subject.profile(99)).to be_a DocusignDtr::Models::Profile
    end
  end

  describe '#all_by_room_id' do
    it 'returns array of users' do
      expect(client).to receive(:get).and_return(users)
      expect(subject.all_by_room_id(99)).to all(be_a(DocusignDtr::Models::User))
    end
  end
end
