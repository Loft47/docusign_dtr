module DocusignDtr
  module Models
    class LoneWolfCommission
      include Virtus.model
      attribute :agent_id
      attribute :end_code
      attribute :end_count
      attribute :commission
    end
  end
end
