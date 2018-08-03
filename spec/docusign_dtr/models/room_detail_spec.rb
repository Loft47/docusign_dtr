require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::RoomDetail do
  subject do
    DocusignDtr::Models::RoomDetail.new(
      buyer1: DocusignDtr::Models::Contact.new,
      buyer2: DocusignDtr::Models::Contact.new,
      room_contacts: [],
      seller1: DocusignDtr::Models::Contact.new,
      seller2: DocusignDtr::Models::Contact.new
    )
  end

  describe '#attributes' do
    it 'has them' do
      expect(subject).to have_attributes(
        buyer1: be_a(DocusignDtr::Models::Contact),
        buyer2: be_a(DocusignDtr::Models::Contact),
        seller1: be_a(DocusignDtr::Models::Contact),
        seller2: be_a(DocusignDtr::Models::Contact)
      )

      expect(subject.attributes.keys).to eq(
        %i[
          actual_close_date api_client_data appraisal_contingency_date bathrooms bedrooms
          binding_date buyer1 buyer2 buyer_agent1_email buyer_agent1_name buyer_agent1_phone
          buyer_agent2_company buyer_agent2_email buyer_agent2_name buyer_agent2_phone
          buyer_side_commission closed_date closed_status_id comment company_address1
          company_address2 company_city company_contact_name company_email company_id
          company_phone company_postal_code company_state contingency_removal_date contract_amount
          contract_date current_listing_amount date_submitted_for_review earnest_money_amount
          entity_holding_earnest_money escrow_provider expected_closing_date financing_type_id
          garages home_warranty_provider inspection_contingency_date insurance_provider
          internal_referral internal_referral_percentage is_under_contract latitude listing_agent1_company
          listing_agent1_email listing_agent1_name listing_agent1_phone listing_agent2_company
          listing_agent2_email listing_agent2_name listing_agent2_phone listing_date listing_expiration_date
          list_side_commission loan_contingency_date local_contract_amount local_currency_id
          local_current_listing_amount local_earnest_money_amount local_original_listing_amount longitude
          lot_size mls_id mortgage_provider offer_date office_id original_listing_amount origin_of_lead_id
          outside_referral outside_referral_percentage property_type_id rejected_date relisting
          room_contacts rooms seller1 seller2 seller_concession special_circumstances_id sq_ft
          survey_provider taxes title_provider units year_built
        ]
      )
    end
  end
end
