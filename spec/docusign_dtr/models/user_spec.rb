require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::User do
  let(:client) { double }
  let(:address) { DocusignDtr::Models::Address.new }
  let(:profile_attrs) do
    {
      user_id: 73_999
    }
  end
  let(:attrs) do
    %i[
      address closed_status_id created_date email first_name is_under_contract
      is_linked_to_account_server last_name latitude longitude mls_id office_id
      owners room_id room_name status user_id
    ]
  end
  subject do
    user = DocusignDtr::Models::User.new(
      address:,
      owners: [DocusignDtr::Models::Owner.new]
    )
    user.client = client
    user
  end

  describe '#attributes' do
    it { expect(subject.attributes.keys).to eq(attrs) }
    it 'has them' do
      expect(subject).to have_attributes(
        address: be_a(DocusignDtr::Models::Address),
        owners: be_a(Array)
      )
    end
  end

  describe '#methods' do
    it '#owners' do
      expect(subject.owners.first).to be_a DocusignDtr::Models::Owner
    end

    it '#profile' do
      expect(client).to receive(:get).and_return(profile_attrs)
      expect(subject.profile).to be_a DocusignDtr::Models::Profile
    end
  end
end
