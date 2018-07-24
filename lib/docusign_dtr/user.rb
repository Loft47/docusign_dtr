module DocusignDtr
  class User
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/users')['users'].map do |user_attrs|
        user = DocusignDtr::Models::User.new(user_attrs)
        user.client = client
        user
      end
    end
  end
end
