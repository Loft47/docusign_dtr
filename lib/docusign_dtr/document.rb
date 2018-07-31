module DocusignDtr
  class Document
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all_by_room_id(room_id)
      @client.get("/rooms/#{room_id}/documents")['documents'].map do |document_attrs|
        document = DocusignDtr::Models::Document.new(document_attrs)
        document.client = client
        document
      end
    end

    def find(id)
      document_attrs = @client.get("/documents/#{id}/details")
      document = DocusignDtr::Models::Document.new(document_attrs)
      document.client = client
      document
    end

    def create(document_attrs = {}) end

    def download(id)
      # document_attrs = @client.get("/documents/#{id}")
    end

    def destroy(id) end

    def update(id) end
  end
end
