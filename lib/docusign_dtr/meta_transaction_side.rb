module DocusignDtr
  class MetaTransactionSide
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/meta/transaction_sides')['entities'].map do |meta_attrs|
        meta = DocusignDtr::Models::MetaTransactionSide.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
