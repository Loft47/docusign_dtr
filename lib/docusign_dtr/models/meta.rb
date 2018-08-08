module DocusignDtr
  module Models
    class Meta
      include Virtus.model
      attribute :id
      attribute :name
      attribute :display_order
      attr_accessor :client
    end
  end
end
