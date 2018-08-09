module DocusignDtr
  module Models
    class Room
      include Virtus.model
      attribute :address, DocusignDtr::Models::Address
      attribute :auction_details, DocusignDtr::Models::AuctionDetail
      attribute :closed_status_id
      attribute :company_room_status_id
      attribute :contract_amount
      attribute :created_date
      attribute :creation_details, DocusignDtr::Models::CreationDetail
      attribute :details, DocusignDtr::Models::RoomDetail
      attribute :integrator_data
      attribute :is_under_contract
      attribute :last_updated_date
      attribute :latitude
      attribute :lone_wolf_details, DocusignDtr::Models::LoneWolfDetail
      attribute :longitude
      attribute :mls_id
      attribute :office_id
      attribute :owners, Array[DocusignDtr::Models::Owner]
      attribute :room_id
      attribute :room_image_url
      attribute :room_name
      attribute :status
      attribute :view_link
      attr_accessor :client

      def documents
        return [] unless room_id
        ::DocusignDtr::Document.new(client: client).all_by_room_id(room_id)
      end

      def task_lists
        return [] unless room_id
        ::DocusignDtr::TaskList.new(client: client).all_by_room_id(room_id)
      end

      def users
        return [] unless room_id
        ::DocusignDtr::User.new(client: client).all_by_room_id(room_id)
      end
    end
  end
end
