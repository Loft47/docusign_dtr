module DocusignDtr
  class Region
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/regions')['regions'].map do |region_attrs|
        region = DocusignDtr::Models::Region.new(region_attrs)
        region.client = client
        region
      end
    end
  end
end
