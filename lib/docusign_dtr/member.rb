module DocusignDtr
  class Member
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/members')['members'].map do |member_attrs|
        member = DocusignDtr::Models::Member.new(member_attrs)
        member.client = client
        member
      end
    end
  end
end
