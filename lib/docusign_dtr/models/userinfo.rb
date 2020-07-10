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

      def guid
        (accounts&.first || {}).fetch('account_id', sub)
      end
    end
  end
end
