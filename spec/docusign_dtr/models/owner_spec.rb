require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::Owner do
  subject { DocusignDtr::Models::Owner.new }

  describe '#attributes' do
    it { expect(subject.attributes.keys).to eq(%i[first_name last_name office_id transaction_side_id user_id]) }
  end
end
