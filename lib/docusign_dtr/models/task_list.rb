module DocusignDtr
  module Models
    class TaskList
      include Virtus.model
      attribute :approval_date
      attribute :approved_by_user_id
      attribute :can_remove
      attribute :id
      attribute :is_general
      attribute :name
      attribute :room_id
      attribute :rejected_date
      attribute :rejected_by_user_id
      attribute :review_status
      attribute :status
      attribute :submitted_for_review_date
      attribute :tasks, [DocusignDtr::Models::Task]
      attribute :task_list_template_id
      attr_accessor :client
    end
  end
end
