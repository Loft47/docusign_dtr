require_relative '../spec_helper'

RSpec.describe DocusignDtr::Client do
  subject { DocusignDtr::Client.new(token: :token) }

  describe '#initialize' do
    it { expect(subject.token).to eq :token }
    it { expect { DocusignDtr::Client.new }.to raise_error(StandardError) }
  end

  describe '#get' do
    let(:array) { ['testResponse' => '99'] }
    let(:hash) { { 'testResponse' => '99' } }
    it 'parses hash' do
      expect(subject).to receive(:raw).with('/test', foo: 123).and_return(hash)
      expect(subject.get('/test', foo: 123)).to eq('test_response' => '99')
    end
    it 'parses array' do
      expect(subject).to receive(:raw).with('/test', foo: 123).and_return(array)
      expect(subject.get('/test', foo: 123)).to eq(['test_response' => '99'])
    end
  end

  describe '#raw' do
    it 'sends request to server' do
      mock
      expect(subject.raw('/test', id: 47)).to include('response' => 'test')
    end

    it 'handles errors' do
      mock(code: 401)
      expect { subject.raw('/test', id: 47) }.to raise_error DocusignDtr::Unauthorized
      mock(code: 403)
      expect { subject.raw('/test', id: 47) }.to raise_error DocusignDtr::Forbidden
      mock(code: 500)
      expect { subject.raw('/test', id: 47) }.to raise_error StandardError
    end
  end

  describe 'Models' do
    it { expect(subject.Office).to be_a DocusignDtr::Office }
    it { expect(subject.Room).to be_a DocusignDtr::Room }
  end

  def mock(code: 200)
    WebMock.reset!
    WebMock
      .stub_request(:get, 'https://stage.cartavi.com/restapi/v1/test?id=47')
      .with(
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'docusign_dtr',
          'Authorization': 'Bearer token'
        }
      )
      .to_return(
        status: code, body: '{ "response": "test" }', headers: { 'Content-Type': 'application/json' }
      )
  end

  describe '#base_uri' do
    it { expect(DocusignDtr::Client.new(token: :t, test_mode: false).base_uri).to eq 'https://cartavi.com/restapi/v1' }
    it { expect(DocusignDtr::Client.new(token: :t).base_uri).to eq 'https://stage.cartavi.com/restapi/v1' }
  end
end
