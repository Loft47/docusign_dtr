module DocusignDtr
  class MetaState
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/meta/states')['entities'].map do |meta_attrs|
        meta = DocusignDtr::Models::MetaState.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
