module DocusignDtr
  class Client
    include HTTParty
    base_uri 'https://stage.cartavi.com/restapi/v1'
    attr_accessor :token

    def initialize(token:, application: 'docusign_dtr')
      @token = token
      @application = application
      raise 'Missing Token' unless token
    end

    def get(page, params = {})
      response = raw(page, params)
      snakify(response)
    end

    def raw(page, params = {})
      response = self.class.get(page, query: params, headers: headers, timeout: 60)
      handle_error(response.code) if response.code != 200
      response.parsed_response
    end

    def handle_error(response_code)
      raise error_type(response_code), "Error communicating: Response code #{response_code}"
    end

    def Office # rubocop:disable  Naming/MethodName
      @office ||= DocusignDtr::Office.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def Room # rubocop:disable  Naming/MethodName
      @room ||= DocusignDtr::Room.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    private

    def headers
      {
        'Authorization': "Bearer #{@token}",
        'User-Agent': @application.to_s,
        'Accept': 'application/json'
      }
    end

    def snakify(hash)
      if hash.is_a? Array
        hash.map(&:to_snake_keys)
      else
        hash.to_snake_keys
      end
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
