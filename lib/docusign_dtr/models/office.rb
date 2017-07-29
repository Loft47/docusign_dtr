module DocusignDtr
  module Models
    class Office
      include Virtus.model

      attribute :id
      attribute :name
      attribute :address
      attribute :phone
      attribute :regionId
      attribute :address, DocusignDtr::Models::Address

      attr_accessor :client
    end
  end
end
