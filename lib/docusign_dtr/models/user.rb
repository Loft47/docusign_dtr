module DocusignDtr
  module Models
    class User
      include Virtus.model
      attribute :address, DocusignDtr::Models::Address
      attribute :closed_status_id
      attribute :created_date
      attribute :first_name
      attribute :is_under_contract
      attribute :last_name
      attribute :latitude
      attribute :longitude
      attribute :mls_id
      attribute :office_id
      attribute :owners, Array[DocusignDtr::Models::Owner]
      attribute :room_id
      attribute :room_name
      attribute :status
      attribute :user_id
      attr_accessor :client
    end
  end
end
