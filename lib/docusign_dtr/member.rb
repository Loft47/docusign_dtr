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

    def find(id)
      member_attrs = @client.get("/members/#{id}")
      member = DocusignDtr::Models::Member.new(member_attrs)
      member.client = client
      member
    end

    def create(member_attrs:) end

    def destroy(document_id:) end

    def update(document_id:) end
  end
end
