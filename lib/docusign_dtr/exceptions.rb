module DocusignDtr
  class ApiLimitExceeded < StandardError; end
  class ConsentRequired < StandardError; end
  class Forbidden < StandardError; end
  class InvalidGrant < StandardError; end
  class InvalidParameter < StandardError; end
  class NoContent < StandardError; end
  class Unauthorized < StandardError; end
end
