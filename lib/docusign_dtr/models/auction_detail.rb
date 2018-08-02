module DocusignDtr
  module Models
    class AuctionDetail
      include Virtus.model
      attribute :buyers_premium
      attribute :contract_sent_to_seller_date
      attribute :deed_recvd_from_seller_date
      attribute :deed_sent_to_seller_date
      attribute :item_number
      attribute :prelim_hud_recvd_from_seller_date
      attribute :prelim_hud_sent_seller_date
      attribute :seller_decision_type_id
      attribute :seller_executed_contract_date
      attribute :subject_to_decision_date
      attribute :subject_to_decision_id
      attribute :subject_to_seller_conf
      attribute :total_purchase_price
      attribute :winning_bid
    end
  end
end
