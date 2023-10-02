require_relative '../spec_helper'

RSpec.describe DocusignDtr::Profile do
  subject { DocusignDtr::Profile.new(client:) }
  let(:client) { double }
  let(:profile_attrs) do
    {
      user_id: 99,
      email: 'string',
      is_linked_to_account_server: true
    }
  end

  describe '#initialize' do
    it { expect(subject.client).to eq client }
    it { expect { DocusignDtr::Profile.new }.to raise_error(StandardError) }
  end

  describe '#find' do
    it 'returns the user profile attributes' do
      expect(client).to receive(:get).and_return(profile_attrs)
      expect(subject.find(99)).to be_a DocusignDtr::Models::Profile
    end
  end
end
