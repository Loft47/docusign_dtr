require 'uri'
require 'base64'
require 'securerandom'
module DocusignDtr
  class Auth
    include HTTParty

    attr_accessor :config
    attr_accessor :auth_uri
    attr_accessor :state

    def initialize(integrator_key:, secret_key:, redirect_uri:, test_mode: true, application: 'docusign_dtr')
      @config = OpenStruct.new(
        integrator_key: integrator_key,
        secret_key: secret_key,
        redirect_uri: redirect_uri,
        test_mode: test_mode,
        application: application
      )
      @state = SecureRandom.uuid
      set_auth_url
      true
    end

    def get_token(response_code:, state: nil)
      raise 'State does ont match. Possible CSRF!' if state && state != @state
      params = { grant_type: :authorization_code, code: response_code }
      response = self.class.post("#{base_uri}oauth/token", query: params, headers: headers, timeout: 60)
      handle_error(response.code) if response.code != 200
      OpenStruct.new(response.parsed_response)
    end

    def refresh_token(refresh_token:)
      params = { grant_type: :refresh_token, refresh_token: refresh_token }
      response = self.class.post("#{base_uri}oauth/token", query: params, headers: headers, timeout: 60)
      handle_error(response.code) if response.code != 200
      OpenStruct.new(response.parsed_response)
    end

    def parse_url_response(url)
      params = URI.decode_www_form(URI(url).query)
      hash = Hash[*params.flatten]
      OpenStruct.new(hash)
    end

    private

    def base_uri
      "https://#{domain}.docusign.com/"
    end

    def domain
      @config.test_mode ? 'account-d' : 'account'
    end

    def set_auth_url
      @auth_uri = URI("#{base_uri}oauth/auth")
      @auth_uri.query = URI.encode_www_form(
        response_type: :code,
        scope: dtr_scope,
        client_id: @config.integrator_key,
        state: @state,
        redirect_uri: @config.redirect_uri
      )
    end

    def dtr_scope
      %w[
        dtr.documents.read
        dtr.documents.write
        dtr.rooms.read
        dtr.rooms.write
        dtr.company.read
        dtr.company.write
        dtr.profile.read
        dtr.profile.write
      ].join(' ')
    end

    def encoded_keys
      Base64.urlsafe_encode64("#{@config.integrator_key}:#{@config.secret_key}")
    end

    def headers
      {
        'Authorization' => "Basic #{encoded_keys}",
        'Content-Type' => 'application/x-www-form-urlencoded',
        'User-Agent' => @config.application,
        'Accept' => '*/*'
      }
    end

    def handle_error(response_code)
      raise error_type(response_code), "Error communicating: Response code #{response_code}"
    end

    def error_type(response_code)
      case response_code
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
