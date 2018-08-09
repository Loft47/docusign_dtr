module DocusignDtr
  class MetaFinancingType
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/meta/financing_types')['entities'].map do |meta_attrs|
        meta = DocusignDtr::Models::MetaFinancingType.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
