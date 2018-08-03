module DocusignDtr
  module Models
    class TaskList
      include Virtus.model
      attribute :id
      attribute :name
      attribute :room_id
      attribute :rejectedDate
      attribute :rejectedByUserId
      attribute :submittedForReviewDate
      attribute :approvedByUserId
      attribute :approvalDate
      attribute :canRemove
      attribute :isGeneral
      attribute :reviewStatus
      attribute :status
      attribute :taskListTemplateId
      attribute :tasks
      attr_accessor :client
    end
  end
end
