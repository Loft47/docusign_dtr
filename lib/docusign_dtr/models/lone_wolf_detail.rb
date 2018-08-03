module DocusignDtr
  module Models
    class LoneWolfDetail
      include Virtus.model
      attribute :agent_commission2, DocusignDtr::Models::LoneWolfCommission
      attribute :agent_commission, DocusignDtr::Models::LoneWolfCommission
      attribute :business_contact, DocusignDtr::Models::Contact
      attribute :client_contact, DocusignDtr::Models::Contact
      attribute :external_agent_commission
      attribute :is_lone_wolf_enabled
      attribute :lone_wolf_id
    end
  end
end
