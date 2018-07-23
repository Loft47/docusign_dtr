require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Auth::Base do
  subject { DocusignDtr::Auth::Base.new }
  let(:url) { 'https://www.google.com?param1=123&param2=234' }

  describe '#initialize' do
    it 'assigns @config' do
      expect(subject.config).to be_a DocusignDtr::Models::AuthConfig
    end
  end

  describe '#parse_url_response' do
    it 'can parse url query parameters' do
      expect(subject.parse_url_response(url)).to have_attributes(
        param1: '123',
        param2: '234'
      )
    end
  end
end
