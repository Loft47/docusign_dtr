module DocusignDtr
  class Room
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/rooms')['rooms'].map do |room_attrs|
        room = DocusignDtr::Models::Room.new(room_attrs)
        room.client = client
        room
      end
    end
  end
end
