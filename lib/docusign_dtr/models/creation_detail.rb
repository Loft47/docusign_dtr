module DocusignDtr
  module Models
    class CreationDetail
      include Virtus.model
      attribute :user_id
      attribute :first_name
      attribute :last_name
      attribute :created
    end
  end
end
