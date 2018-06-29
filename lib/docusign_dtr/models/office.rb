module DocusignDtr
  module Models
    class Office
      include Virtus.model
      attribute :id
      attribute :name
      attribute :address, DocusignDtr::Models::Address
      attribute :phone
      attribute :regionId
      attr_accessor :client
    end
  end
end
