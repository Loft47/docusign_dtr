require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::Userinfo do
  subject { described_class.new }
  let(:attrs) { %i[accounts email family_name given_name name sub] }
  let(:userinfo) { described_class.new(sub: 1234, accounts: accounts) }
  let(:accounts) { nil }

  describe '#attributes' do
    it { expect(subject.attributes.keys).to eq(attrs) }
  end

  describe '#guid' do
    it { expect(userinfo.guid).to eq 1234 }

    context 'with account' do
      let(:accounts) { [{ 'account_id' => 9876 }] }
      it { expect(userinfo.guid).to eq 9876 }
    end
  end
end
