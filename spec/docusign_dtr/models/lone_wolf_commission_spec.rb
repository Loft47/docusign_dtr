require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::LoneWolfCommission do
  subject { DocusignDtr::Models::LoneWolfCommission.new }

  describe '#attributes' do
    it { expect(subject.attributes.keys).to eq(%i[agent_id end_code end_count commission]) }
  end
end
