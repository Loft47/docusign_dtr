module DocusignDtr
  class MetaActivityType
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/meta/activity_types')['entities'].map do |meta_attrs|
        meta = DocusignDtr::Models::MetaActivityType.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
