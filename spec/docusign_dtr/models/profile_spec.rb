require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::Profile do
  let(:client) { double }
  end
  let(:attrs) do
    %i[
      access_level company_id company_manager_title_id company_name
      default_office_id facebook_url first_name in_app_help integrator_data
      last_name linked_in_url logo_url office_list picture_url primary_currency_id
      region_list role_id time_zone_id twitter_url web_site_url
    ]
  end
  subject do
    profile = DocusignDtr::Models::Profile.new
    profile.client = client
    profile
  end

  describe '#attributes' do
    it { expect(subject.attributes.keys).to eq(attrs) }
  end
end
