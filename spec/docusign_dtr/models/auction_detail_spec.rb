require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::AuctionDetail do
  subject { DocusignDtr::Models::AuctionDetail.new }

  describe '#attributes' do
    it 'has them' do
      expect(subject.attributes.keys).to eq(
        %i[
          buyers_premium contract_sent_to_seller_date deed_recvd_from_seller_date deed_sent_to_seller_date
          item_number prelim_hud_recvd_from_seller_date prelim_hud_sent_seller_date seller_decision_type_id
          seller_executed_contract_date subject_to_decision_date subject_to_decision_id
          subject_to_seller_conf total_purchase_price winning_bid
        ]
      )
    end
  end
end
