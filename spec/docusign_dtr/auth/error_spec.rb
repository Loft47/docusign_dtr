require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Auth::Error do
  subject { DocusignDtr::Auth::Error.new(response: response) }

  let(:response) { double(code: code, parsed_response: parsed_response) }
  let(:code) { 200 }
  let(:parsed_response) { nil }
  let(:full_message) { "Error communicating: Response code #{code}" }

  describe '#build' do
    context 'success response' do
      it 'returns no error' do
        expect(subject.build).to be_nil
      end
    end

    context 'unauthorized' do
      let(:code) { 401 }
      it 'returns correct error class' do
        expect { subject.build }.to raise_error(DocusignDtr::Unauthorized)
      end
    end

    context 'forbidden' do
      let(:code) { 403 }
      it 'returns correct error class' do
        expect { subject.build }.to raise_error(DocusignDtr::Forbidden, '')
      end
    end

    context 'no content' do
      let(:code) { 204 }
      it 'returns correct error class' do
        expect { subject.build }.to raise_error(DocusignDtr::NoContent, '')
      end
    end

    context 'general error' do
      let(:code) { 400 }

      context 'missing consent' do
        let(:parsed_response) { { "error": 'consent_required' } }
        it 'returns correct error class' do
          expect { subject.build }.to raise_error(DocusignDtr::ConsentRequired, 'consent_required')
        end
      end

      context 'invalid grant' do
        let(:parsed_response) { { "error": 'invalid_grant' } }
        it 'returns correct error class' do
          expect { subject.build }.to raise_error(DocusignDtr::InvalidGrant, 'invalid_grant')
        end
      end

      context 'api limit exceeded' do
        let(:parsed_response) { { "errorCode": 'HOURLY_APIINVOCATION_LIMIT_EXCEEDED' } }
        it 'returns correct error class' do
          expect { subject.build }.to raise_error(
            DocusignDtr::ApiLimitExceeded, 'HOURLY_APIINVOCATION_LIMIT_EXCEEDED'
          )
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
