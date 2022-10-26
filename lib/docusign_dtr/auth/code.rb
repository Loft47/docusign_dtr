require 'securerandom'
module DocusignDtr
  module Auth
    class Code < Base
      attr_accessor :userinfo

      # rubocop:disable Metrics/ParameterLists, Lint/MissingSuper
      def initialize(integrator_key:,
                     secret_key:,
                     redirect_uri:,
                     test_mode: true,
                     state: nil,
                     application: 'docusign_dtr')
        @config = DocusignDtr::Models::AuthConfig.new(
          application: application,
          integrator_key: integrator_key,
          redirect_uri: redirect_uri,
          secret_key: secret_key,
          state: state || SecureRandom.uuid,
          test_mode: test_mode
        )
      end
      # rubocop:enable Metrics/ParameterLists, Lint/MissingSuper

      def request_token(code:, state: nil)
        raise 'State does not match. Possible CSRF!' if state && state != @config.state

        params = { grant_type: :authorization_code, code: code }
        response = self.class.post(auth_uri, query: params, headers: headers, timeout: 60)
        handle_error(response)
        @token_response = DocusignDtr::Models::AuthTokenResponse.new(response.parsed_response)
      end

      def refresh_token
        raise 'No token to refresh' unless @token_response&.refresh_token

        params = { grant_type: :refresh_token, refresh_token: @token_response.refresh_token }
        response = self.class.post("#{base_uri}oauth/token", query: params, headers: headers, timeout: 60)
        handle_error(response)
        @token_response = DocusignDtr::Models::AuthTokenResponse.new(response.parsed_response)
      end

      def user_info
        raise 'No token to obtain userinfo' unless @token_response&.access_token

        response = self.class.get("#{base_uri}oauth/userinfo", headers: user_info_headers, timeout: 60)
        handle_error(response)
        @userinfo = DocusignDtr::Models::Userinfo.new(response.parsed_response)
      end

      private

      def headers
        base_headers.merge('Authorization': "Basic #{encoded_integrator_key}")
      end

      def user_info_headers
        base_headers.merge('Authorization': "Bearer #{@token_response.access_token}")
      end
    end
  end
end
