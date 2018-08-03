require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::Contact do
  subject { DocusignDtr::Models::Contact.new(email: 'test@example.com') }

  describe '#attributes' do
    it 'has them' do
      expect(subject.attributes.keys).to eq(
        %i[
          address1 address2 business_phone cell_phone city company contact_index
          country_id email home_phone name phone postal_code room_contact_id
          room_contact_type room_contact_type_id room_id side state_id
        ]
      )
    end

    it 'aliases email' do
      expect(subject.email_address).to eq('test@example.com')
      subject.email_address = 'change@example.com'
      expect(subject.email).to eq('change@example.com')
    end
  end
end
