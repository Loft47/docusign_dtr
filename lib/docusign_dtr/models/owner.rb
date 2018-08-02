module DocusignDtr
  module Models
    class Owner
      include Virtus.model
      attribute :first_name
      attribute :last_name
      attribute :office_id
      attribute :transaction_side_id
      attribute :user_id
    end
  end
end
