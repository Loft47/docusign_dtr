require 'jwt'
require 'uri'
module DocusignDtr
  module Auth
    class Jwt
      include HTTParty
      EXPIRES_IN = 3600

      attr_accessor :config
      attr_accessor :token_response

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

      def grant_url
        grant_uri = URI("#{base_uri}oauth/auth")
        grant_uri.query = URI.encode_www_form(
          response_type: :code,
          scope: full_scope,
          client_id: @config.integrator_key,
          redirect_uri: @config.redirect_uri
        )
        grant_uri.to_s
      end

      def request_token
        response = self.class.post(auth_uri, query: access_token_params, headers: headers, timeout: 60)
        handle_error(response) if response.code != 200
        @token_response = DocusignDtr::Models::AuthTokenResponse.new(response.parsed_response)
      end

      private

      def full_scope
        (%w[signature impersonation] + DocusignDtr::DTR_SCOPE).join(' ')
      end

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

      def base_uri
        "https://#{domain}/"
      end

      def domain
        @config.test_mode ? 'account-d.docusign.com' : 'account.docusign.com'
      end

      def auth_uri
        @auth_uri ||= URI("#{base_uri}oauth/token")
      end

      def headers
        {
          'Content-Type': 'application/x-www-form-urlencoded',
          'User-Agent': @config.application.to_s,
          'Accept': '*/*'
        }
      end

      def handle_error(response)
        raise error_type(response), "Error communicating: Response code #{response.code}"
      end

      def error_type(response)
        case response.code
        when 400
          # {"error":"invalid_grant"}
          return DocusignDtr::InvalidGrant if response.parsed_response['error'].match?(/grant/)
          DocusignDtr::ConsentRequired # {"error":"consent_required"}
        when 401
          DocusignDtr::Unauthorized
        when 403
          DocusignDtr::Forbidden
        else
          StandardError
        end
      end
    end
  end
end
