module DocusignDtr
  class User
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def user_info
      user_attrs = @client.get('/users/user_info')
      user = DocusignDtr::Models::User.new(user_attrs)
      user.client = client
      user
    end

    def profile(user_id)
      profile_attrs = @client.get("/users/#{user_id}/profile")
      profile = DocusignDtr::Models::Profile.new(profile_attrs)
      profile.client = client
      profile
    end

    def all_by_room_id(room_id)
      @client.get("/rooms/#{room_id}/users")['users'].map do |user_attrs|
        user = DocusignDtr::Models::User.new(user_attrs)
        user.client = client
        user
      end
    end
  end
end
