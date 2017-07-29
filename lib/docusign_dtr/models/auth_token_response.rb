module DocusignDtr
  module Models
    class AuthTokenResponse
      include Virtus.model
      attribute :access_token
      attribute :token_type
      attribute :refresh_token
      attribute :expires_in
    end
  end
end
