module DocusignDtr
  class Document
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all_by_room(room_id:)
      @client.get("/rooms/#{room_id}/documents")['documents'].map do |document_attrs|
        document = DocusignDtr::Models::Document.new(document_attrs)
        document.client = client
        document
      end
    end

    def find(document_id:)
      document_attrs = @client.get("/documents/#{document_id}/details")
      document = DocusignDtr::Models::Document.new(document_attrs)
      document.client = client
      document
    end

    def download(document_id:)
      # @client.get("/documents/#{document_id}")
    end

    def destroy(document_id:)
      # @client.delete("/documents/#{document_id}")
    end

  end
end
