require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Auth::Jwt do
  let(:application) { :application }
  let(:integrator_key) { :client_id }
  let(:private_key) { :private_key }
  let(:redirect_uri) { :redirect_uri }
  let(:test_mode) { true }
  let(:user_guid) { :user_guid }
  subject do
    DocusignDtr::Auth::Jwt.new(
      application: application,
      integrator_key: integrator_key,
      private_key: private_key,
      redirect_uri: redirect_uri,
      test_mode: test_mode,
      user_guid: user_guid
    )
  end

  describe '#initialize' do
    it 'assigns @config' do
      expect(OpenSSL::PKey::RSA).to receive(:new).and_return(:rsa_key)
      expect(subject.config).to have_attributes(
        application: application,
        integrator_key: integrator_key,
        private_key: :rsa_key,
        redirect_uri: redirect_uri,
        test_mode: test_mode,
        user_guid: user_guid
      )
    end
  end

  describe '#grant_url' do
    it 'creates a grant url' do
      expect(OpenSSL::PKey::RSA).to receive(:new).and_return(:rsa_key)
      expected = 'https://account-d.docusign.com/oauth/auth?response_type=code&scope=signature+impersonation+dtr.documents.read+dtr.documents.write+dtr.rooms.read+dtr.rooms.write+dtr.company.read+dtr.company.write+dtr.profile.read+dtr.profile.write&client_id=client_id&redirect_uri=redirect_uri'
      expect(subject.grant_url).to eq expected
    end
  end

  describe '#request_token' do
    it 'should return an AuthTokenReponse' do
      json = '{ "access_token": "trust_no_one", "token_type": "Bearer", "expires_in": 3600 }'
      expect(OpenSSL::PKey::RSA).to receive(:new).and_return(:rsa_key)
      expect(JWT).to receive(:encode).and_return(:trust_no_one)
      WebMock.reset!
      WebMock
        .stub_request(:post, 'https://account-d.docusign.com/oauth/token?assertion=trust_no_one&grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer')
        .with(
          headers: {
            'Accept': '*/*',
            'Content-Type': 'application/x-www-form-urlencoded',
            'User-Agent': 'application'
          }
        )
        .to_return(
          status: 200, body: json, headers: { 'Content-Type': 'application/json' }
        )
      expect(subject.request_token).to be_a DocusignDtr::Models::AuthTokenResponse
    end
  end
end
