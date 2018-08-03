module DocusignDtr
  module Models
    class Activity
      include Virtus.model
      attribute :document_activity_id
      attribute :action
      attribute :activity_date
      attribute :comment
      attribute :activity_source
      attribute :by_user
      attr_accessor :client
    end
  end
end
