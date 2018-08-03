require_relative '../spec_helper'

RSpec.describe DocusignDtr::Activity do
  subject { DocusignDtr::Activity.new(client: client) }
  let(:client) { double }
  let(:activities) { { 'activity' => [activity] } }
  let(:activity) do
    {
      document_activity_id: 99
    }
  end

  describe '#initialize' do
    it { expect(subject.client).to eq client }
    it { expect { DocusignDtr::Activity.new }.to raise_error(StandardError) }
  end

  describe '#all_by_task_id' do
    it 'returns array of activities' do
      expect(client).to receive(:get).and_return(activities)
      expect(subject.all_by_task_id(activity['document_activity_id']).first).to be_a DocusignDtr::Models::Activity
    end
  end
end
