require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Auth::Code do
  let(:application) { :application }
  let(:integrator_key) { :client_id }
  let(:secret_key) { :secret_key }
  let(:redirect_uri) { :redirect_uri }
  let(:test_mode) { true }
  subject do
    auth = described_class.new(
      application: application,
      integrator_key: integrator_key,
      secret_key: secret_key,
      redirect_uri: redirect_uri,
      test_mode: test_mode
    )
    auth.token_response = DocusignDtr::Models::AuthTokenResponse.new(
      access_token: :some_token, refresh_token: :refresh_token
    )
    auth
  end
  let(:auth_data) { { access_token: 'trust_no_one', token_type: 'Bearer', 'expires_in': 3600 }.to_json }
  let(:user_data) do
    {
      sub: '4799e5e9',
      name: 'Susan Smart',
      given_name: 'Susan',
      family_name: 'Smart',
      created: '2015-08-13T22:03:03.45',
      email: 'ssmart@example.com',
      accounts: [{ account_id: 'a4ec37d6' }]
    }.to_json
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
    it 'should return an AuthTokenReponse' do
      mock_request
      expect(subject.request_token(code: :code, state: :state)).to be_a DocusignDtr::Models::AuthTokenResponse
    end
  end

  describe '#refresh_token' do
    it 'should return an AuthTokenReponse' do
      mock_refresh
      expect(subject.refresh_token).to be_a DocusignDtr::Models::AuthTokenResponse
    end
  end

  describe '#user_info' do
    it 'should return the userinfo record' do
      mock_user_info
      response = subject.user_info
      expect(response).to be_a DocusignDtr::Models::Userinfo
      expect(response.sub).to eq '4799e5e9'
    end
  end

  def mock_request
    WebMock.reset!
    WebMock
      .stub_request(:post, 'https://account-d.docusign.com/oauth/token?grant_type=authorization_code&code=code')
      .with(accept_headers).to_return(success_result.merge(body: auth_data))
  end

  def mock_refresh
    WebMock.reset!
    WebMock
      .stub_request(:post, 'https://account-d.docusign.com/oauth/token?grant_type=refresh_token&refresh_token=refresh_token')
      .with(accept_headers).to_return(success_result.merge(body: auth_data))
  end

  def mock_user_info
    WebMock.reset!
    WebMock
      .stub_request(:get, 'https://account-d.docusign.com/oauth/userinfo')
      .with(user_info_headers).to_return(success_result.merge(body: user_data))
  end

  def base_headers
    { 'Accept': '*/*', 'Content-Type': 'application/x-www-form-urlencoded', 'User-Agent': 'application' }
  end

  def accept_headers
    { headers: base_headers }
  end

  def success_result
    { status: 200, body: '', headers: { 'Content-Type': 'application/json' } }
  end

  def user_info_headers
    { headers: base_headers.merge('Authorization': 'Bearer some_token') }
  end
end
