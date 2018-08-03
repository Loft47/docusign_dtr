module DocusignDtr
  module Models
    class Contact
      include Virtus.model
      attribute :address1
      attribute :address2
      attribute :business_phone
      attribute :cell_phone
      attribute :city
      attribute :company
      attribute :contact_index
      attribute :country_id
      attribute :email
      attribute :home_phone
      attribute :name
      attribute :phone
      attribute :postal_code
      attribute :room_contact_id
      attribute :room_contact_type
      attribute :room_contact_type_id
      attribute :room_id
      attribute :side
      attribute :state_id
      alias_method :email_address, :email
      alias_method :email_address=, :email=
    end
  end
end
