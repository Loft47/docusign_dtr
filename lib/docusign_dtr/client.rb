module DocusignDtr
  class Client
    include HTTParty
    base_uri 'https://stage.cartavi.com/restapi/v1'
    attr_accessor :token

    def initialize(access_token:, application: 'docusign_dtr')
      @access_token = access_token
      @application = application
      raise 'Missing Token' unless @access_token
    end

    def get(page, params = {})
      response = raw(page, params)
      self.class.snakify(response)
    end

    def raw(page, params = {})
      response = self.class.get(page, query: params, headers: headers, timeout: 60)
      handle_error(response.code) if response.code != 200
      response.parsed_response
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

    def Office
      @office ||= DocusignDtr::Office.new(client: self)
    end

    def self.snakify(hash)
      if hash.is_a? Array
        hash.map(&:to_snake_keys)
      else
        hash.to_snake_keys
      end
    end

    private

    def headers
      {
        'Authorization' => "Bearer #{@access_token}",
        'User-Agent' => @application,
        'Accept' => 'application/json'
      }
    end
  end
end
