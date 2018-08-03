module DocusignDtr
  class Meta
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/metas')['metas'].map do |meta_attrs|
        meta = DocusignDtr::Models::Meta.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
