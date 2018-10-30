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

  before(:each) do
    expect(OpenSSL::PKey::RSA).to receive(:new).and_return(:rsa_key)
  end
  context '#initialize' do
    it 'assigns @config' do
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
      expected = 'https://account-d.docusign.com/oauth/auth?response_type=code&scope=signature+impersonation+dtr.documents.read+dtr.documents.write+dtr.rooms.read+dtr.rooms.write+dtr.company.read+dtr.company.write+dtr.profile.read+dtr.profile.write&client_id=client_id&redirect_uri=redirect_uri'
      expect(subject.grant_url).to eq expected
    end
  end

  describe '#request_token' do
    before(:each) do
      expect(JWT).to receive(:encode).and_return(:trust_no_one)
    end
    context 'success' do
      let(:json) { '{ "access_token": "trust_no_one", "token_type": "Bearer", "expires_in": 3600 }' }
      it 'should return an AuthTokenReponse' do
        mockit(code: 200, body: json)
        expect(subject.request_token).to be_a DocusignDtr::Models::AuthTokenResponse
      end
    end

    context 'success' do
      let(:json) { '{ "access_token": "trust_no_one", "token_type": "Bearer", "expires_in": 3600 }' }
      it 'should return an AuthTokenReponse' do
        mockit(body: json)
        expect(subject.request_token).to be_a DocusignDtr::Models::AuthTokenResponse
      end
    end

    context 'missing consent' do
      let(:json) { '{ "error": "consent_required" }' }
      it 'should return a Missing Consent Error' do
        mockit(code: 400, body: json)
        expect { subject.request_token }.to raise_error DocusignDtr::ConsentRequired
      end
    end

    context 'Invalid Grant' do
      let(:json) { '{ "error": "invalid_grant" }' }
      it 'should return a Grant Error' do
        mockit(code: 400, body: json)
        expect { subject.request_token }.to raise_error DocusignDtr::InvalidGrant
      end
    end

    context 'Api limit exceeded' do
      let(:json) { '{ "error": "HOURLY_APIINVOCATION_LIMIT_EXCEEDED" }' }
      it 'should return a Api Limit Exceeded error' do
        mockit(code: 400, body: json)
        expect { subject.request_token }.to raise_error DocusignDtr::ApiLimitExceeded
      end
    end

    context 'Unauthorized' do
      it 'should return an Unauthorized error' do
        mockit(code: 401)
        expect { subject.request_token }.to raise_error DocusignDtr::Unauthorized
      end
    end

    context 'Forbidden' do
      it 'should return an Forbidden error' do
        mockit(code: 403)
        expect { subject.request_token }.to raise_error DocusignDtr::Forbidden
      end
    end

    context 'Other errors' do
      let(:json) { '{ "error": "Internal Server Error" }' }
      it 'should return a Standard Error' do
        mockit(code: 500, body: json)
        expect { subject.request_token }.to raise_error StandardError
      end
    end
  end

  def mockit(code: 200, body: '')
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
        status: code, body: body, headers: { 'Content-Type': 'application/json' }
      )
  end
end
