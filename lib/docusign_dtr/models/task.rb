module DocusignDtr
  module Models
    class Task
      include Virtus.model
      attribute :assignments
      attribute :calculated_due_date
      attribute :can_agent_delete
      attribute :can_agent_edit
      attribute :can_approve
      attribute :can_assign_documents
      attribute :can_delete
      attribute :can_edit
      attribute :can_mark_complete
      attribute :can_mark_incomplete
      attribute :can_reject
      attribute :can_remove_approval
      attribute :can_review
      attribute :can_send_reminder
      attribute :can_view
      attribute :completed_by_user_id
      attribute :completed_date
      attribute :created_date
      attribute :display_order
      attribute :documents, Array[DocusignDtr::Models::Document]
      attribute :due_date_offset
      attribute :due_date_type_id
      attribute :is_approved
      attribute :is_awaiting_review
      attribute :is_declined
      attribute :is_document_task
      attribute :is_new
      attribute :name
      attribute :reminders
      attribute :required_task
      attribute :requires_approval
      attribute :requires_review
      attribute :room_id
      attribute :status
      attribute :status_date
      attribute :task_activity_comment_count
      attribute :task_id
      attribute :task_list_id
      attribute :task_list_name
      attribute :task_list_owner, DocusignDtr::Models::Owner
      attribute :updated_date
      attr_accessor :client
      alias_method :id, :task_id
      alias_method :id=, :task_id=

      def activities
        return [] unless task_id
        ::DocusignDtr::Activity.new(client: client).all_by_task_id(task_id)
      end
    end
  end
end
