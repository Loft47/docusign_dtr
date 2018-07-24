module DocusignDtr
  module Models
    class Document
      include Virtus.model
      attribute :id
      attribute :name
      attribute :content_type
      attribute :is_new
      attribute :created_date
      attribute :file_size
      attribute :is_signed
      attribute :owner_id
      attribute :room_id
      attribute :folder_id
      attr_accessor :client
    end
  end
end
