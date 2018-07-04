module DocusignDtr
  module Models
    class Office
      include Virtus.model
      attribute :id
      attribute :office_name
      attribute :address, DocusignDtr::Models::Address
      attribute :phone
      attr_accessor :client
    end
  end
end
