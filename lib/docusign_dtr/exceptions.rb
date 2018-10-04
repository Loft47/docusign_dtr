module DocusignDtr
  class ConsentRequired < StandardError; end
  class InvalidGrant < StandardError; end
  class InvalidParameter < StandardError; end
  class Forbidden < StandardError; end
  class NoContent < StandardError; end
  class Unauthorized < StandardError; end
end
