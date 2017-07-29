module DocusignDtr
  class Office
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/offices')['offices'].map do |office_attrs|
        office = DocusignDtr::Models::Office.new(office_attrs)
        office.client = client
        office
      end
    end
  end
end
