module DocusignDtr
  module Models
    class Address
      include Virtus.model
      attribute :address1
      attribute :address2
      attribute :city
      attribute :county
      attribute :stateId
      attribute :postalCode
      attribute :countryId
      attribute :timeZoneId

      attr_accessor :client
    end
  end
end
