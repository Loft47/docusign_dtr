module DocusignDtr
  module Models
    class Room
      include Virtus.model
      attribute :actual_close_date
      attribute :address # , DocusignDtr::Models::Address
      attribute :appraisal_contingency_date
      attribute :binding_date
      attribute :closed_date
      attribute :closed_status_id
      attribute :closed_status_id
      attribute :comment
      attribute :company_address1
      attribute :company_address2
      attribute :company_city
      attribute :company_contact_name
      attribute :company_email
      attribute :company_id
      attribute :company_phone
      attribute :company_postal_code
      attribute :company_room_status_id
      attribute :company_state
      attribute :contingency_removal_date
      attribute :contract_amount
      attribute :contract_date
      attribute :created_date
      attribute :current_listing_amount
      attribute :date_submitted_for_review
      attribute :earnest_money_amount
      attribute :entity_holding_earnest_money
      attribute :escrow_provider
      attribute :expected_closing_date
      attribute :financing_type_id
      attribute :home_warranty_provider
      attribute :inspection_contingency_date
      attribute :insurance_provider
      attribute :is_under_contract
      attribute :is_under_contract
      attribute :last_updated_date
      attribute :latitude
      attribute :listing_date
      attribute :listing_expiration_date
      attribute :loan_contingency_date
      attribute :local_contract_amount
      attribute :local_currency_id
      attribute :local_current_listing_amount
      attribute :local_earnest_money_amount
      attribute :local_original_listing_amount
      attribute :longitude
      attribute :mls_id
      attribute :mortgage_provider
      attribute :offer_date
      attribute :office_id
      attribute :origin_of_lead_id
      attribute :original_listing_amount
      attribute :owners # , DocusignDtr::Models::Owner
      attribute :property_type_id
      attribute :rejected_date
      attribute :relisting
      attribute :room_id
      attribute :room_name
      attribute :special_circumstances_id
      attribute :status
      attribute :survey_provider
      attribute :title_provider
      attribute :view_link
      attribute :year_built
      attr_accessor :client

      def documents
        return [] unless room_id
        ::DocusignDtr::Document.new(client: client).all_by_room_id(room_id)
      end
    end
  end
end
