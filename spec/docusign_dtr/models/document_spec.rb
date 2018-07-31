require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::Document do
  let(:client) { double }
  let(:document_attrs) {
    {
      id: 99,
      name: "Google.pdf",
      content_type: "application/pdf",
      owner_id: 102286,
      is_virtual: false,
      file_size: "383764",
      owner: {"user_id"=>102286, "first_name"=>"Manny", "last_name"=>"Manager", "company_name"=>"Loft 47"},
      creation_details: {"created"=>"2018-07-31T14:25:16"},
      folder_id: 0,
      folder_name: "Transaction Docs",
      is_new: false,
      can_rename: true,
      can_copy: true,
      can_move: true,
      can_email: true,
      can_fax: true,
      can_create_envelope: true,
      can_download: true,
      can_print: true,
      can_delete: true,
      can_review: false,
      can_assign_to_task_list: false,
      can_remove_from_task_list: false,
      can_split: true,
      can_combine: true,
      can_edit: true,
      people_with_access: 1,
      is_signed: false,
      links: [{"name"=>"Download", "url"=>"https://stage.cartavi.com/restapi/v1/documents/114254"},
        {"name"=>"Details", "url"=>"https://stage.cartavi.com/restapi/v1/documents/114254/details"}]
    }
  }
  subject do
    document = DocusignDtr::Models::Document.new(
      document_attrs
    )
    document.client = client
    document
  end

  describe '#attributes' do
    it 'has them' do
      expect(subject).to have_attributes(
        document_attrs
      )
    end
  end
end
