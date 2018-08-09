module DocusignDtr
  class MetaCountry
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/meta/countries')['entities'].map do |meta_attrs|
        meta = DocusignDtr::Models::MetaCountry.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
