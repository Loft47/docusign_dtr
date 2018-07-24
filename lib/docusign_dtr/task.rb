module DocusignDtr
  class Task
    attr_accessor :client

    def initialize(client:)
      @client = client
    end

    def all
      @client.get('/tasks')['tasks'].map do |task_attrs|
        task = DocusignDtr::Models::Task.new(task_attrs)
        task.client = client
        task
      end
    end
  end
end
