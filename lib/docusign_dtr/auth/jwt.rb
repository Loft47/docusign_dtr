require 'jwt'
module DocusignDtr
  module Auth
    class Jwt < Base
      EXPIRES_IN = 3600
      # rubocop:disable Metrics/ParameterLists
      def initialize(integrator_key:,
                     private_key:,
                     user_guid:,
                     redirect_uri:,
                     test_mode: true,
                     application: 'docusign_dtr')
        @config = DocusignDtr::Models::AuthConfig.new(
          application: application,
          integrator_key: integrator_key,
          private_key: OpenSSL::PKey::RSA.new(private_key),
          redirect_uri: redirect_uri,
          test_mode: test_mode,
          user_guid: user_guid
        )
      end
      # rubocop:enable Metrics/ParameterLists

      def request_token
        response = self.class.post(auth_uri, query: access_token_params, headers: base_headers, timeout: 60)
        handle_error(response)
        @token_response = DocusignDtr::Models::AuthTokenResponse.new(response.parsed_response)
      end

      private

      def body_params
        {
          iss: @config.integrator_key,
          sub: @config.user_guid,
          aud: domain,
          iat: Time.now.to_i,
          exp: Time.now.to_i + EXPIRES_IN,
          scope: full_scope
        }
      end

      def access_token_params
        {
          grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
          assertion: JWT.encode(body_params, @config.private_key, 'RS256')
        }
      end
    end
  end
end
