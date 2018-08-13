module DocusignDtr
  module Models
    class Region
      include Virtus.model
      attribute :agent_count
      attribute :id
      attribute :manager_count
      attribute :name
      attribute :office_count
      attr_accessor :client
    end
  end
end
