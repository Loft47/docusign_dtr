module DocusignDtr
  class TaskList
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/task_lists')['task_lists'].map do |task_list_attrs|
        task_list = DocusignDtr::Models::TaskList.new(task_list_attrs)
        task_list.client = client
        task_list
      end
    end
  end
end
