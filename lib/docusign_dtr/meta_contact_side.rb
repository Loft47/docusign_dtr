module DocusignDtr
  class MetaContactSide
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/meta/contact_sides')['entities'].map do |meta_attrs|
        meta = DocusignDtr::Models::MetaContactSide.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
