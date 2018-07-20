require 'securerandom'
module DocusignDtr
  module Auth
    class Code < Base
      def initialize(integrator_key:,
                     secret_key:,
                     redirect_uri:,
                     test_mode: true,
                     application: 'docusign_dtr')
        @config = DocusignDtr::Models::AuthConfig.new(
          application: application,
          integrator_key: integrator_key,
          redirect_uri: redirect_uri,
          secret_key: secret_key,
          state: SecureRandom.uuid,
          test_mode: test_mode
        )
      end

      def request_token(code:, state: nil)
        raise 'State does ont match. Possible CSRF!' if state && state != @config.state
        params = { grant_type: :authorization_code, code: code }
        response = self.class.post(auth_uri, query: params, headers: headers, timeout: 60)
        handle_error(response.code) if response.code != 200
        @token_response = DocusignDtr::Models::AuthTokenResponse.new(response.parsed_response)
      end

      def refresh_token
        raise 'No token to refresh' unless @token_response&.access_token
        params = { grant_type: :refresh_token, refresh_token: @token_response.access_token }
        response = self.class.post("#{base_uri}oauth/token", query: params, headers: headers, timeout: 60)
        handle_error(response.code) if response.code != 200
        @token_response = DocusignDtr::Models::AuthTokenResponse.new(response.parsed_response)
      end

      private

      def headers
        base_headers.merge('Authorization': "Basic #{encoded_integrator_key}")
      end
    end
  end
end
