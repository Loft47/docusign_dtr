require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::TaskList do
  subject do
    DocusignDtr::Models::TaskList.new(
      tasks: [DocusignDtr::Models::Task.new]
    )
  end
  let(:attr) do
    %i[
      approval_date approved_by_user_id can_remove id is_general name
      room_id rejected_date rejected_by_user_id review_status status
      submitted_for_review_date tasks task_list_template_id
    ]
  end

  describe '#attributes' do
    it { expect(subject.attributes.keys).to eq(attr) }
    it 'has dependent attributes' do
      expect(subject).to have_attributes(
        tasks: be_a(Array)
      )
    end
    it 'has collection of tasks' do
      expect(subject.tasks.first).to be_a(DocusignDtr::Models::Task)
    end
  end
end
