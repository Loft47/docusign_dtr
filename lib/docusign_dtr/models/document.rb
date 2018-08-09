module DocusignDtr
  module Models
    class Document
      include Virtus.model
      attribute :can_assign_to_task_list
      attribute :can_combine
      attribute :can_copy
      attribute :can_create_envelope
      attribute :can_delete
      attribute :can_download
      attribute :can_edit
      attribute :can_email
      attribute :can_fax
      attribute :can_move
      attribute :can_print
      attribute :can_remove_from_task_list
      attribute :can_rename
      attribute :can_review
      attribute :can_split
      attribute :content_type
      attribute :created_date
      attribute :creation_details
      attribute :file_size
      attribute :folder_id
      attribute :folder_name
      attribute :id
      attribute :is_new
      attribute :is_signed
      attribute :is_signed
      attribute :is_virtual
      attribute :links
      attribute :name
      attribute :owner
      attribute :owner_id
      attribute :people_with_access
      attribute :place_holder_id
      attribute :place_holder_name
      attribute :room_id
      attr_accessor :client
      alias_method :document_id, :id
      alias_method :document_id=, :id=
      alias_method :document_name, :name
      alias_method :document_name=, :name=

      def download
        DocusignDtr::Document.download(id)
      end
    end
  end
end
