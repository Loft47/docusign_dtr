require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Auth::Error do
  subject { DocusignDtr::Auth::Error.new(response: response) }

  let(:response) { double(code: code, parsed_response: parsed_response) }
  let(:code) { 200 }
  let(:parsed_response) { nil }
  let(:full_message) { "Error communicating: Response code #{code}" }

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
        expect { subject.build }.to raise_error(DocusignDtr::Unauthorized, full_message)
      end
    end

    context 'forbidden' do
      let(:code) { 403 }
      it 'returns correct error class' do
        expect { subject.build }.to raise_error(DocusignDtr::Forbidden, full_message)
      end
    end

    context 'no content' do
      let(:code) { 204 }
      it 'returns correct error class' do
        expect { subject.build }.to raise_error(DocusignDtr::NoContent, full_message)
      end
    end

    context 'general error' do
      let(:code) { 400 }

      context 'missing consent' do
        let(:parsed_response) { { "error": 'consent_required' } }
        it 'returns correct error class' do
          expect { subject.build }.to raise_error(DocusignDtr::ConsentRequired, full_message)
        end
      end

      context 'invalid grant' do
        let(:parsed_response) { { "error": 'invalid_grant' } }
        it 'returns correct error class' do
          expect { subject.build }.to raise_error(DocusignDtr::InvalidGrant, full_message)
        end
      end

      context 'api limit exceeded' do
        let(:parsed_response) { { "error": 'HOURLY_APIINVOCATION_LIMIT_EXCEEDED' } }
        it 'returns correct error class' do
          expect { subject.build }.to raise_error(DocusignDtr::ApiLimitExceeded, full_message)
        end
      end

      context 'standard / unknown error' do
        let(:parsed_response) { { "errorCode": 'unknown error', "errorDetails": 'something went wrong' } }
        it 'returns correct error class' do
          expect { subject.build }.to raise_error(StandardError)
        end

        it 'returns correct message' do
          expect { subject.build }.to raise_error(StandardError, 'unknown error: something went wrong')
        end
      end
    end
  end
end