module DocusignDtr
  module Models
    class AuthConfig
      include Virtus.model
      attribute :application
      attribute :integrator_key
      attribute :private_key
      attribute :redirect_uri
      attribute :secret_key
      attribute :state
      attribute :test_mode
      attribute :user_guid
    end
  end
end
