module DocusignDtr
  class MetaTaskDateType
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/meta/task_date_types')['entities'].map do |meta_attrs|
        meta = DocusignDtr::Models::MetaTaskDateType.new(meta_attrs)
        meta.client = client
        meta
      end
    end
  end
end
