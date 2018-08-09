require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::Activity do
  let(:client) { double }
  let(:activity_attrs) do
    {
      document_activity_id: 99,
      action: 'Added',
      activity_date: '2018-06-27T21:10:54.843',
      comment: '',
      activity_source: 'ra',
      by_user: DocusignDtr::Models::User.new
    }
  end
  subject do
    activity = DocusignDtr::Models::Activity.new(
      activity_attrs
    )
    activity.client = client
    activity
  end

  describe '#attributes' do
    it 'has them' do
      expect(subject).to have_attributes(
        activity_attrs
      )
    end
  end
end
