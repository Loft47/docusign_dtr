module DocusignDtr
  class MetaCurrency
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/meta/currencies')['entities'].map do |meta_attrs|
        meta = DocusignDtr::Models::MetaCurrency.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
