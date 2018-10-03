module DocusignDtr
  class Room
    attr_accessor :client

    MAX_ROOMS = 100
    MAX_BATCHES = 10_000

    def initialize(client:)
      @client = client
    end

    def all(options = {})
      options[:count] ||= MAX_ROOMS
      rooms = []
      (1..MAX_BATCHES).each do
        current_batch = batch(options)
        rooms += current_batch
        break if current_batch.size < options[:count]
      end
      rooms
    end

    def batch(options = {})
      @client.get('/rooms', query_params(options))['rooms'].map do |room_attrs|
        room = DocusignDtr::Models::Room.new(room_attrs)
        room.client = client
        room
      end
    rescue DocusignDtr::NoContent
      []
    end

    def query_params(options)
      DocusignDtr::QueryParamHelper.call(options)
    end

    def find(id)
      room_attrs = @client.get("/rooms/#{id}")
      room = DocusignDtr::Models::Room.new(room_attrs)
      room.client = client
      room
    end

    def create(attrs = {}) end

    def destroy(id) end

    def update(attrs = {}) end
  end
end
