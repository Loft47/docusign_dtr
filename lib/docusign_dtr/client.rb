module DocusignDtr
  class Client
    include HTTParty
    attr_accessor :token

    def initialize(token:, test_mode: true, application: 'docusign_dtr')
      @test_mode = test_mode
      @token = token
      @application = application
      raise 'Missing Token' unless token
    end

    def get(page, params = {})
      response = raw(page, params)
      snakify(response)
    end

    def raw(page, params = {})
      full_path = [base_uri, page].join
      response = self.class.get(full_path, query: params, headers: headers, timeout: 60)
      handle_error(response.code) if response.code != 200
      response.parsed_response
    end

    def handle_error(response_code)
      raise error_type(response_code), "Error communicating: Response code #{response_code}"
    end

    def Office # rubocop:disable  Naming/MethodName
      @office ||= DocusignDtr::Office.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def Document # rubocop:disable  Naming/MethodName
      @document ||= DocusignDtr::Document.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def Member # rubocop:disable  Naming/MethodName
      @member ||= DocusignDtr::Member.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def Meta # rubocop:disable  Naming/MethodName
      @meta ||= DocusignDtr::Meta.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def Room # rubocop:disable  Naming/MethodName
      @room ||= DocusignDtr::Room.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def Task # rubocop:disable  Naming/MethodName
      @task ||= DocusignDtr::Task.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def TaskList # rubocop:disable  Naming/MethodName
      @task_list ||= DocusignDtr::TaskList.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def Title # rubocop:disable  Naming/MethodName
      @title ||= DocusignDtr::Title.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def User # rubocop:disable  Naming/MethodName
      @user ||= DocusignDtr::User.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def base_uri
      @base_uri ||= @test_mode ? 'https://stage.cartavi.com/restapi/v1' : 'https://cartavi.com/restapi/v1'
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
