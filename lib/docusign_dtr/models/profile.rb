module DocusignDtr
  module Models
    class Profile
      include Virtus.model
      attribute :access_level
      attribute :company_id
      attribute :company_manager_title_id
      attribute :company_name
      attribute :default_office_id
      attribute :facebook_url
      attribute :first_name
      attribute :in_app_help
      attribute :integrator_data
      attribute :last_name
      attribute :linked_in_url
      attribute :logo_url
      attribute :office_list
      attribute :picture_url
      attribute :primary_currency_id
      attribute :region_list
      attribute :role_id
      attribute :time_zone_id
      attribute :twitter_url
      attribute :web_site_url
      attr_accessor :client
    end
  end
end
