require 'uri'
require 'base64'
module DocusignDtr
  module Auth
    class Base
      include HTTParty

      attr_accessor :config, :token_response

      def initialize
        @config = DocusignDtr::Models::AuthConfig.new
      end

      def grant_url
        grant_uri = URI("#{base_uri}oauth/auth")
        grant_uri.query = URI.encode_www_form(grant_params)
        grant_uri.to_s
      end

      def parse_url_response(url)
        params = URI.decode_www_form(URI(url).query)
        hash = Hash[*params.flatten]
        OpenStruct.new(hash) # rubocop:disable Style/OpenStructUse
      end

      private

      def full_scope
        (%w[signature impersonation] + DocusignDtr::DTR_SCOPE).join(' ')
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

      def grant_params
        {
          response_type: :code,
          scope: full_scope,
          state: @config.state,
          client_id: @config.integrator_key,
          redirect_uri: @config.redirect_uri
        }.compact
      end

      def base_headers
        {
          'Content-Type': 'application/x-www-form-urlencoded',
          'User-Agent': @config.application.to_s,
          Accept: '*/*'
        }
      end

      def encoded_integrator_key
        Base64.urlsafe_encode64("#{@config.integrator_key}:#{@config.secret_key}")
      end

      def handle_error(response)
        DocusignDtr::Auth::Error.new(response:).build
      end
    end
  end
end
