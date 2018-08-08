module DocusignDtr
  class MetaOriginOfLeadType
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/meta/origin_of_lead_types')['entities'].map do |meta_attrs|
        meta = DocusignDtr::Models::MetaOriginOfLeadType.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
