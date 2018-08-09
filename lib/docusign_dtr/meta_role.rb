module DocusignDtr
  class MetaRole
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/meta/roles')['entities'].map do |meta_attrs|
        meta = DocusignDtr::Models::MetaRole.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
