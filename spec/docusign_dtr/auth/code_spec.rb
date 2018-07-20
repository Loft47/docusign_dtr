require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Auth::Code do
  let(:application) { :application }
  let(:integrator_key) { :client_id }
  let(:secret_key) { :secret_key }
  let(:redirect_uri) { :redirect_uri }
  let(:test_mode) { true }
  subject do
    DocusignDtr::Auth::Code.new(
      application: application,
      integrator_key: integrator_key,
      secret_key: secret_key,
      redirect_uri: redirect_uri,
      test_mode: test_mode
    )
  end

  before(:each) do
    expect(SecureRandom).to receive(:uuid).and_return(:state)
  end
  context '#initialize' do
    it 'assigns @config' do
      expect(subject.config).to have_attributes(
        application: application,
        integrator_key: integrator_key,
        secret_key: secret_key,
        state: :state,
        redirect_uri: redirect_uri,
        test_mode: test_mode
      )
    end
  end

  describe '#grant_url' do
    it 'creates a grant url' do
      expected = 'https://account-d.docusign.com/oauth/auth?response_type=code&scope=signature+impersonation+dtr.documents.read+dtr.documents.write+dtr.rooms.read+dtr.rooms.write+dtr.company.read+dtr.company.write+dtr.profile.read+dtr.profile.write&state=state&client_id=client_id&redirect_uri=redirect_uri'
      expect(subject.grant_url).to eq expected
    end
  end

  describe '#request_token' do
    context 'success' do
      it 'should return an AuthTokenReponse' do
        mock_request
        expect(subject.request_token(code: :code, state: :state)).to be_a DocusignDtr::Models::AuthTokenResponse
      end
    end
  end

  describe '#refresh_token' do
    context 'success' do
      it 'should return an AuthTokenReponse' do
        mock_refresh
        subject.token_response = DocusignDtr::Models::AuthTokenResponse.new(access_token: :expired_token)
        expect(subject.refresh_token).to be_a DocusignDtr::Models::AuthTokenResponse
      end
    end
  end

  def mock_request
    WebMock.reset!
    body = '{ "access_token": "trust_no_one", "token_type": "Bearer", "expires_in": 3600 }'
    WebMock
      .stub_request(:post, 'https://account-d.docusign.com/oauth/token?grant_type=authorization_code&code=code')
      .with(
        headers: {
          'Accept': '*/*',
          'Content-Type': 'application/x-www-form-urlencoded',
          'User-Agent': 'application'
        }
      )
      .to_return(
        status: 200, body: body, headers: { 'Content-Type': 'application/json' }
      )
  end

  def mock_refresh
    WebMock.reset!
    body = '{ "access_token": "trust_no_one", "token_type": "Bearer", "expires_in": 3600 }'
    WebMock
      .stub_request(:post, 'https://account-d.docusign.com/oauth/token?grant_type=refresh_token&refresh_token=expired_token')
      .with(
        headers: {
          'Accept': '*/*',
          'Content-Type': 'application/x-www-form-urlencoded',
          'User-Agent': 'application'
        }
      )
      .to_return(
        status: 200, body: body, headers: { 'Content-Type': 'application/json' }
      )
  end
end
