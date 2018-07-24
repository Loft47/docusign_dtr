module DocusignDtr
  module Models
    class TaskList
      include Virtus.model
      attribute :room_id
      attribute :room_name
      attribute :mls_id
      attribute :address, DocusignDtr::Models::Address
      attribute :owners # , DocusignDtr::Models::Owner
      attribute :office_id
      attribute :latitude
      attribute :longitude
      attribute :closed_status_id
      attribute :created_date
      attribute :is_under_contract
      attribute :status
      attr_accessor :client
    end
  end
end
