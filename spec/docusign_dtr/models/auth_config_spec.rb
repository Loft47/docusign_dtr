require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::AuthConfig do
  subject do
    DocusignDtr::Models::AuthConfig.new(
      application: 'TestAppplication',
      integrator_key: '1234',
      private_key: :my_private_key,
      redirect_uri: 'https://www.bookface.com',
      secret_key: '1234',
      state: :state,
      test_mode: true,
      user_guid: :user_guid
    )
  end

  describe '#attributes' do
    it 'has them' do
      expect(subject).to have_attributes(
        application: 'TestAppplication',
        integrator_key: '1234',
        private_key: :my_private_key,
        redirect_uri: 'https://www.bookface.com',
        secret_key: '1234',
        state: :state,
        test_mode: true,
        user_guid: :user_guid
      )
    end
  end
end
