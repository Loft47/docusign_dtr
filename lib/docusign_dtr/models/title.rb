module DocusignDtr
  module Models
    class Title
      include Virtus.model
      attribute :id
      attribute :title
      attribute :member_count
      attr_accessor :client
    end
  end
end
