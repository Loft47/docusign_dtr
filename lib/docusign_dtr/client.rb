module DocusignDtr
  class Client # rubocop:disable Metrics/ClassLength
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
      handle_error(response)
      response.parsed_response
    end

    def handle_error(response)
      DocusignDtr::Auth::Error.new(response: response).build
    end

    def Document # rubocop:disable  Naming/MethodName
      @document ||= DocusignDtr::Document.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def Member # rubocop:disable  Naming/MethodName
      @member ||= DocusignDtr::Member.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaActivityType # rubocop:disable  Naming/MethodName
      @meta_activity_type ||= DocusignDtr::MetaActivityType.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaClosingStatus # rubocop:disable  Naming/MethodName
      @meta_closing_status ||= DocusignDtr::MetaClosingStatus.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaContactSide # rubocop:disable  Naming/MethodName
      @meta_contact_side ||= DocusignDtr::MetaContactSide.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaCountry # rubocop:disable  Naming/MethodName
      @meta_country ||= DocusignDtr::MetaCountry.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaCurrency # rubocop:disable  Naming/MethodName
      @meta_currency ||= DocusignDtr::MetaCurrency.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaFinancingType # rubocop:disable  Naming/MethodName
      @meta_financing_type ||= DocusignDtr::MetaFinancingType.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaOriginOfLeadType # rubocop:disable  Naming/MethodName
      @meta_origin_of_lead_type ||= DocusignDtr::MetaOriginOfLeadType.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaPropertyType # rubocop:disable  Naming/MethodName
      @meta_property_type ||= DocusignDtr::MetaPropertyType.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaRole # rubocop:disable  Naming/MethodName
      @meta_role ||= DocusignDtr::MetaRole.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaRoomContactType # rubocop:disable  Naming/MethodName
      @meta_room_contact_type ||= DocusignDtr::MetaRoomContactType.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaSellerDecisionType # rubocop:disable  Naming/MethodName
      @meta_seller_decision_type ||= DocusignDtr::MetaSellerDecisionType.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaSpecialCircumstanceType # rubocop:disable  Naming/MethodName
      @meta_special_circumstance_type ||= DocusignDtr::MetaSpecialCircumstanceType.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaState # rubocop:disable  Naming/MethodName
      @meta_state ||= DocusignDtr::MetaState.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaTaskDateType # rubocop:disable  Naming/MethodName
      @meta_task_date_type ||= DocusignDtr::MetaTaskDateType.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaTimezone # rubocop:disable  Naming/MethodName
      @meta_timezone ||= DocusignDtr::MetaTimezone.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def MetaTransactionSide # rubocop:disable  Naming/MethodName
      @meta_transaction_side ||= DocusignDtr::MetaTransactionSide.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def Office # rubocop:disable  Naming/MethodName
      @office ||= DocusignDtr::Office.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def Room # rubocop:disable  Naming/MethodName
      @room ||= DocusignDtr::Room.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def Region # rubocop:disable  Naming/MethodName
      @region ||= DocusignDtr::Region.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def TaskList # rubocop:disable  Naming/MethodName
      @task_list ||= DocusignDtr::TaskList.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def Activity # rubocop:disable  Naming/MethodName
      @activity ||= DocusignDtr::Activity.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def Title # rubocop:disable  Naming/MethodName
      @title ||= DocusignDtr::Title.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def User # rubocop:disable  Naming/MethodName
      @user ||= DocusignDtr::User.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def Profile # rubocop:disable  Naming/MethodName
      @profile ||= DocusignDtr::Profile.new(client: self) # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def base_uri
      @base_uri ||= @test_mode ? 'https://demo.rooms.docusign.com/restapi/v1' : 'https://rooms.docusign.com/restapi/v1'
    end

    private

    def headers
      {
        'Authorization': "Bearer #{@token}",
        'User-Agent': @application.to_s,
        'Accept': 'application/json'
      }
    end

    def snakify(object)
      return object.map(&:to_snake_keys) if object.is_a? Array
      return object if object.is_a? String

      object.to_snake_keys
    end
  end
end
