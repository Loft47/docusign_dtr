module DocusignDtr
  module Auth
    class Error
      def initialize(response:)
        @response = response
      end

      def build
        return nil if @response.code == 200

        exception_class, message = exception
        raise exception_class, (message.present? ? message : full_message)
      end

      def full_message
        "Error communicating: Response code #{@response.code}"
      end

      def exception
        case @response.code
        when 400
          general_error
        when 401
          DocusignDtr::Unauthorized
        when 403
          DocusignDtr::Forbidden
        when 204
          DocusignDtr::NoContent
        else
          StandardError
        end
      end

      private

      def general_error
        return DocusignDtr::InvalidGrant if error_code.match?(/grant/)
        return DocusignDtr::ApiLimitExceeded if error_code.match?(/HOURLY_APIINVOCATION_LIMIT_EXCEEDED/)
        return DocusignDtr::ConsentRequired if error_code.match?(/consent_required/)

        [StandardError, [error_code, error_message].compact.join(': ')]
      end

      def error_code
        return '' unless parsed_response

        @error_code ||= parsed_response.fetch(:error, nil) || parsed_response.fetch(:errorCode, '')
      end

      def error_message
        parsed_response.fetch(:message, nil) || parsed_response.fetch(:errorDetails, '')
      end

      def parsed_response
        @parsed_response ||= @response.parsed_response&.transform_keys(&:to_sym)
      end
    end
  end
end
