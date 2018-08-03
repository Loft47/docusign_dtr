require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::LoneWolfDetail do
  subject do
    DocusignDtr::Models::LoneWolfDetail.new(
      agent_commission2: DocusignDtr::Models::LoneWolfCommission.new,
      agent_commission: DocusignDtr::Models::LoneWolfCommission.new,
      business_contact: DocusignDtr::Models::Contact.new,
      client_contact: DocusignDtr::Models::Contact.new
    )
  end
  let(:attr) do
    %i[
      agent_commission2 agent_commission business_contact client_contact external_agent_commission
      is_lone_wolf_enabled lone_wolf_id
    ]
  end

  describe '#attributes' do
    it { expect(subject.attributes.keys).to eq(attr) }
    it 'has dependent attributes' do
      expect(subject).to have_attributes(
        agent_commission2: be_a(DocusignDtr::Models::LoneWolfCommission),
        agent_commission: be_a(DocusignDtr::Models::LoneWolfCommission),
        business_contact: be_a(DocusignDtr::Models::Contact),
        client_contact: be_a(DocusignDtr::Models::Contact)
      )
    end
  end
end
