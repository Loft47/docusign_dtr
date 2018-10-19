require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::Userinfo do
  let(:attrs) do
    %i[accounts email family_name given_name name sub]
  end
  subject { described_class.new }
  describe '#attributes' do
    it { expect(subject.attributes.keys).to eq(attrs) }
  end
end
