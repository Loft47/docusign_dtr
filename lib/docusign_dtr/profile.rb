module DocusignDtr
  class Profile
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def find(user_id)
      profile_attrs = @client.get("/users/#{user_id}/profile")
      profile = DocusignDtr::Models::Profile.new(profile_attrs)
      profile.client = client
      profile
    end
  end
end
