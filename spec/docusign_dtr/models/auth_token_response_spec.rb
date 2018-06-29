require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::AuthTokenResponse do
  subject do
    DocusignDtr::Models::AuthTokenResponse.new(
      access_token: '1234',
      token_type: '1234',
      refresh_token: '1234',
      expires_in: '1234'
    )
  end

  describe '#attributes' do
    it 'has them' do
      expect(subject).to have_attributes(
        access_token: '1234',
        token_type: '1234',
        refresh_token: '1234',
        expires_in: '1234'
      )
    end
  end
end
