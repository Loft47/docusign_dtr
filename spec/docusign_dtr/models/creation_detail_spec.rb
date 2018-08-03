require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::CreationDetail do
  subject { DocusignDtr::Models::CreationDetail.new }

  describe '#attributes' do
    it { expect(subject.attributes.keys).to eq(%i[user_id first_name last_name created]) }
  end
end
