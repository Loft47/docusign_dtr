module DocusignDtr
  class MetaTimezone
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/meta/timezones')['entities'].map do |meta_attrs|
        meta = DocusignDtr::Models::MetaTimezone.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
