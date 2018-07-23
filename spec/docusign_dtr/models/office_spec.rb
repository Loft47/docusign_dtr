require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::Office do
  let(:client) { double }
  let(:address) { DocusignDtr::Models::Address.new }
  subject do
    office = DocusignDtr::Models::Office.new(
      id: 99,
      office_name: 'Main Office',
      address: address,
      phone: '555-555-5555'
    )
    office.client = client
    office
  end

  describe '#attributes' do
    it 'has them' do
      expect(subject).to have_attributes(
        id: 99,
        office_name: 'Main Office',
        address: address,
        phone: '555-555-5555'
      )
    end
  end
end
