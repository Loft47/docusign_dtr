module DocusignDtr
  class TaskList
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all_by_room_id(room_id)
      @client.get("/rooms/#{room_id}/task_lists").map do |task_list_attrs|
        task_list = DocusignDtr::Models::TaskList.new(task_list_attrs)
        task_list.client = client
        task_list
      end
    end

    def find(id)
      task_list_attrs = @client.get("/task_lists/#{id}")
      task_list = DocusignDtr::Models::TaskList.new(task_list_attrs)
      task_list.client = client
      task_list
    end
  end
end
