require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::Task do
  let(:client) { double }
  let(:activities) { { 'activity' => [activity_attrs] } }
  let(:activity_attrs) do
    {
      document_activity_id: 99,
      action: 'Added',
      activity_date: '2018-06-27T21:10:54.843',
      comment: '',
      activity_source: 'ra',
      by_user: {
        first_name: 'Robinson',
        last_name: 'Cruzoe',
        user_id: 88
      }
    }
  end
  subject do
    task = DocusignDtr::Models::Task.new(
      documents: [DocusignDtr::Models::Document.new],
      name: 'task',
      room_id: 11,
      task_id: 99,
      task_list_owner: DocusignDtr::Models::Owner.new
    )
    task.client = client
    task
  end
  let(:attr) do
    %i[
      assignments calculated_due_date can_agent_delete can_agent_edit 
      can_approve can_assign_documents can_delete can_edit can_mark_complete
      can_mark_incomplete can_reject can_remove_approval can_review
      can_send_reminder can_view completed_by_user_id completed_date
      created_date display_order documents due_date_offset due_date_type_id
      is_approved is_awaiting_review is_declined is_document_task is_new
      name reminders required_task requires_approval requires_review room_id
      status status_date task_activity_comment_count task_id task_list_id
      task_list_name task_list_owner updated_date
    ]
  end

  describe '#attributes' do
    it { expect(subject.attributes.keys).to eq(attr) }
    it 'has dependent attributes' do
      expect(subject).to have_attributes(
        documents: be_a(Array),
        task_list_owner: be_a(DocusignDtr::Models::Owner)
      )
    end
  end

  describe '#methods' do
    it '#activities' do
      expect(client).to receive(:get).and_return(activities)
      expect(subject.activities.first).to be_a DocusignDtr::Models::Activity
    end
  end
end
