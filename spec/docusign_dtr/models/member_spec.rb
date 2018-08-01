require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::Member do
  let(:client) { double }
  subject do
    member = DocusignDtr::Models::Member.new(
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
    )
    member.client = client
    member
  end

  describe '#attributes' do
    it 'has them' do
      expect(subject).to have_attributes(
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
      )
    end
  end
end
