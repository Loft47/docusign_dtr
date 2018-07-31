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

    def find(room_id)
      room_attrs = @client.get("/rooms/#{room_id}")
      room = DocusignDtr::Models::Room.new(room_attrs)
      room.client = client
      room
    end

    def create(attrs = {}) end

    def destroy(id) end

    def update(attrs = {}) end
  end
end
