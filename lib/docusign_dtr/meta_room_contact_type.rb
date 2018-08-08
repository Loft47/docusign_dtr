module DocusignDtr
  class MetaRoomContactType
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/meta/room_contact_types')['entities'].map do |meta_attrs|
        meta = DocusignDtr::Models::MetaRoomContactType.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
