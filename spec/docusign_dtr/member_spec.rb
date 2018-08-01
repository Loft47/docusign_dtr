require_relative '../spec_helper'

RSpec.describe DocusignDtr::Member do
  subject { DocusignDtr::Member.new(client: client) }
  let(:client) { double }
  let(:members) { { 'members' => [member] } }
  let(:member) do
    {
      id: 121_110,
      profile: {
        email: 'member@loft.com',
        first_name: 'Mr. Bot',
        last_name: 'Chat'
      },
      is_locked_out: false,
      status: 'Pending',
      default_office_id: 1150,
      company_role_id: 0
    }
  end

  describe '#initialize' do
    it { expect(subject.client).to eq client }
    it { expect { DocusignDtr::Member.new }.to raise_error(StandardError) }
  end

  describe '#all' do
    it 'returns array of member' do
      expect(client).to receive(:get).and_return(members)
      expect(subject.all.first).to be_a DocusignDtr::Models::Member
    end
  end

  describe '#find' do
    it 'returns one member object' do
      expect(client).to receive(:get).and_return(member)
      expect(subject.find(member['id'])).to be_a DocusignDtr::Models::Member
    end
  end

  describe '#create' do
    skip
  end

  describe '#destroy' do
    skip
  end

  describe '#update' do
    skip
  end
end
