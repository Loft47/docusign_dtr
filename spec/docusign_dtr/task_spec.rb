require_relative '../spec_helper'

RSpec.describe DocusignDtr::TaskList do
  subject { DocusignDtr::TaskList.new(client: client) }
  let(:client) { double }
  let(:room_id) { 99 }
  let(:task_lists) { { 'task_lists' => [task_list] } }
  let(:task_list) do
    {
      id: 73_999,
      name: 'Do something please',
      roomId: 99,
      canRemove: true,
      isGeneral: false,
      reviewStatus: 'CanReview',
      status: 'Open',
      taskListTemplateId: 5_855,
      tasks: []
    }
  end

  describe '#initialize' do
    it { expect(subject.client).to eq client }
    it { expect { DocusignDtr::TaskList.new }.to raise_error(StandardError) }
  end

  describe '#all' do
    it 'returns array of task_lists' do
      expect(client).to receive(:get).and_return(task_lists)
      expect(subject.all_by_room_id(room_id).first).to be_a DocusignDtr::Models::TaskList
    end
  end

  describe '#find' do
    it 'returns one task_list object' do
      expect(client).to receive(:get).and_return(task_list)
      expect(subject.find(73_999)).to be_a DocusignDtr::Models::Member
    end
  end
end
