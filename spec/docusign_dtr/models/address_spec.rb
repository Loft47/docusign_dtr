require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::Address do
  let(:client) { double }
  subject do
    address = DocusignDtr::Models::Address.new(
      address1: '1234 street1',
      address2: 'PO BOX 1234',
      city: 'Testville',
      county: 'USA',
      state_id: 'WA',
      postal_code: '30210',
      country_id: 'USA',
      time_zone_id: 'PDT'
    )
    address.client = client
    address
  end

  describe '#attributes' do
    it 'has them' do
      expect(subject).to have_attributes(
        address1: '1234 street1',
        address2: 'PO BOX 1234',
        city: 'Testville',
        county: 'USA',
        state_id: 'WA',
        postal_code: '30210',
        country_id: 'USA',
        time_zone_id: 'PDT'
      )
    end
  end
end
