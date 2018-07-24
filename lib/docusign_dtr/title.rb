module DocusignDtr
  class Title
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/titles')['titles'].map do |title_attrs|
        title = DocusignDtr::Models::Title.new(title_attrs)
        title.client = client
        title
      end
    end
  end
end
