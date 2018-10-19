module DocusignDtr
  module Models
    class Userinfo
      include Virtus.model
      attribute :accounts
      attribute :email
      attribute :family_name
      attribute :given_name
      attribute :name
      attribute :sub
    end
  end
end
