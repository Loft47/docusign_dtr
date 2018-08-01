module DocusignDtr
  module Models
    class Member
      include Virtus.model
      attribute :agent
      attribute :company_role_id
      attribute :default_office_id
      attribute :id
      attribute :inbound_email
      attribute :is_locked_out
      attribute :locked_out_reason
      attribute :manager_access
      attribute :manager
      attribute :permission_profile_id
      attribute :profile
      attribute :status
      attr_accessor :client
    end
  end
end
