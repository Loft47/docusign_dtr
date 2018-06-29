require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::AuthConfig do
  subject do
    DocusignDtr::Models::AuthConfig.new(
      integrator_key: '1234',
      secret_key: '1234',
      redirect_uri: 'https://www.bookface.com',
      test_mode: true,
      application: 'TestAppplication'
    )
  end

  describe '#attributes' do
    it 'has them' do
      expect(subject).to have_attributes(
        integrator_key: '1234',
        secret_key: '1234',
        redirect_uri: 'https://www.bookface.com',
        test_mode: true,
        application: 'TestAppplication'
      )
    end
  end
end
