require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Auth::Error do
  subject { DocusignDtr::Auth::Error.new(response: response) }

  let(:response) { double(code: code, parsed_response: json) }
  let(:code) { 200 }
  let(:json) { nil }

  describe '#full_message' do
    it 'returns error message with code' do
      expect(subject.full_message).to include(code.to_s)
    end
  end

  describe '#build' do
    context 'success response' do
      it 'returns no error' do
        expect(subject.build).to be_nil
      end
    end

    context 'unauthorized' do
      let(:code) { 401 }
      it 'returns correct error class' do
        expect(subject.build.class).to eq DocusignDtr::Unauthorized
      end
    end

    context 'forbidden' do
      let(:code) { 403 }
      it 'returns correct error class' do
        expect(subject.build.class).to eq DocusignDtr::Forbidden
      end
    end

    context 'no content' do
      let(:code) { 204 }
      it 'returns correct error class' do
        expect(subject.build.class).to eq DocusignDtr::NoContent
      end
    end

    context 'general error' do
      let(:code) { 400 }

      context 'missing consent' do
        let(:json) { { "error": 'consent_required' } }
        it 'returns correct error class' do
          expect(subject.build.class).to eq DocusignDtr::ConsentRequired
        end
      end

      context 'invalid grant' do
        let(:json) { { "error": 'invalid_grant' } }
        it 'returns correct error class' do
          expect(subject.build.class).to eq DocusignDtr::InvalidGrant
        end
      end

      context 'api limit exceeded' do
        let(:json) { { "error": 'HOURLY_APIINVOCATION_LIMIT_EXCEEDED' } }
        it 'returns correct error class' do
          expect(subject.build.class).to eq DocusignDtr::ApiLimitExceeded
        end
      end
    end
  end
end
