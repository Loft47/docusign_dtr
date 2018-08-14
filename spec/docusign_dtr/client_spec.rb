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
    let(:string) { 'testResponse' }
    it 'parses hash' do
      expect(subject).to receive(:raw).with('/test', foo: 123).and_return(hash)
      expect(subject.get('/test', foo: 123)).to eq('test_response' => '99')
    end
    it 'parses array' do
      expect(subject).to receive(:raw).with('/test', foo: 123).and_return(array)
      expect(subject.get('/test', foo: 123)).to eq(['test_response' => '99'])
    end
    it 'parses string' do
      expect(subject).to receive(:raw).with('/test', foo: 123).and_return(string)
      expect(subject.get('/test', foo: 123)).to eq('testResponse')
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
    it { expect(subject.Document).to be_a DocusignDtr::Document }
    it { expect(subject.Member).to be_a DocusignDtr::Member }
    it { expect(subject.MetaActivityType).to be_a DocusignDtr::MetaActivityType }
    it { expect(subject.MetaClosingStatus).to be_a DocusignDtr::MetaClosingStatus }
    it { expect(subject.MetaContactSide).to be_a DocusignDtr::MetaContactSide }
    it { expect(subject.MetaCountry).to be_a DocusignDtr::MetaCountry }
    it { expect(subject.MetaCurrency).to be_a DocusignDtr::MetaCurrency }
    it { expect(subject.MetaFinancingType).to be_a DocusignDtr::MetaFinancingType }
    it { expect(subject.MetaOriginOfLeadType).to be_a DocusignDtr::MetaOriginOfLeadType }
    it { expect(subject.MetaPropertyType).to be_a DocusignDtr::MetaPropertyType }
    it { expect(subject.MetaRole).to be_a DocusignDtr::MetaRole }
    it { expect(subject.MetaRoomContactType).to be_a DocusignDtr::MetaRoomContactType }
    it { expect(subject.MetaSellerDecisionType).to be_a DocusignDtr::MetaSellerDecisionType }
    it { expect(subject.MetaSpecialCircumstanceType).to be_a DocusignDtr::MetaSpecialCircumstanceType }
    it { expect(subject.MetaState).to be_a DocusignDtr::MetaState }
    it { expect(subject.MetaTaskDateType).to be_a DocusignDtr::MetaTaskDateType }
    it { expect(subject.MetaTimezone).to be_a DocusignDtr::MetaTimezone }
    it { expect(subject.MetaTransactionSide).to be_a DocusignDtr::MetaTransactionSide }
    it { expect(subject.Office).to be_a DocusignDtr::Office }
    it { expect(subject.Region).to be_a DocusignDtr::Region }
    it { expect(subject.Room).to be_a DocusignDtr::Room }
    it { expect(subject.TaskList).to be_a DocusignDtr::TaskList }
    it { expect(subject.Activity).to be_a DocusignDtr::Activity }
    it { expect(subject.Title).to be_a DocusignDtr::Title }
    it { expect(subject.User).to be_a DocusignDtr::User }
    it { expect(subject.Profile).to be_a DocusignDtr::Profile }
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
