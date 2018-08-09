module DocusignDtr
  class MetaClosingStatus
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/meta/closing_statuses')['entities'].map do |meta_attrs|
        meta = DocusignDtr::Models::MetaClosingStatus.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
