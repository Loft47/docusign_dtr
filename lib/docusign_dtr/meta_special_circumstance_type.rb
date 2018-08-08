module DocusignDtr
  class MetaSpecialCircumstanceType
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/meta/special_circumstances_types')['entities'].map do |meta_attrs|
        meta = DocusignDtr::Models::MetaSpecialCircumstanceType.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
