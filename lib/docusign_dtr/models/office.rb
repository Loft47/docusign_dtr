module DocusignDtr
  module Models
    class Office
      include Virtus.model
      attribute :address, DocusignDtr::Models::Address
      attribute :agent_count
      attribute :id
      attribute :manager_count
      attribute :office_name
      attribute :phone
      attribute :region_id
      attr_accessor :client
    end
  end
end
