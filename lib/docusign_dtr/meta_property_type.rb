module DocusignDtr
  class MetaPropertyType
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/meta/property_types')['entities'].map do |meta_attrs|
        meta = DocusignDtr::Models::MetaPropertyType.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
