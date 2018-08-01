module DocusignDtr
  class Activity
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all_by_task_id(task_id)
      @client.get("/tasks/{task_id}/activity")['activity'].map do |activity_attrs|
        activity = DocusignDtr::Models::Activity.new(activity_attrs)
        activity.client = client
        activity
      end
    end
  end
end

