module DocusignDtr
  module Models
    class Address
      include Virtus.model
      attribute :address1
      attribute :address2
      attribute :city
      attribute :county
      attribute :state_id
      attribute :postal_code
      attribute :country_id
      attribute :time_zone_id
    end
  end
end
