require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::Address do
  let(:client) { double }
  subject do
    address = DocusignDtr::Models::Address.new(
      address1: '1234 street1',
      address2: 'PO BOX 1234',
      city: 'Testville',
      county: 'USA',
      stateId: 'WA',
      postalCode: '30210',
      countryId: 'USA',
      timeZoneId: 'PDT'
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
        stateId: 'WA',
        postalCode: '30210',
        countryId: 'USA',
        timeZoneId: 'PDT'
      )
    end
  end
end
