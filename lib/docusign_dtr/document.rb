module DocusignDtr
  class Document
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/documents')['documents'].map do |document_attrs|
        document = DocusignDtr::Models::Document.new(document_attrs)
        document.client = client
        document
      end
    end
  end
end
