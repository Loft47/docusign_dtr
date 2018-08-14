require 'plissken'
require 'httparty'
require 'virtus'
require 'jwt'

require 'docusign_dtr/version'
require 'docusign_dtr/exceptions'
require 'docusign_dtr/auth/base'
require 'docusign_dtr/auth/code'
require 'docusign_dtr/auth/jwt'
require 'docusign_dtr/client'
require 'docusign_dtr/activity'
require 'docusign_dtr/document'
require 'docusign_dtr/member'
require 'docusign_dtr/meta_activity_type'
require 'docusign_dtr/meta_closing_status'
require 'docusign_dtr/meta_contact_side'
require 'docusign_dtr/meta_country'
require 'docusign_dtr/meta_currency'
require 'docusign_dtr/meta_financing_type'
require 'docusign_dtr/meta_origin_of_lead_type'
require 'docusign_dtr/meta_property_type'
require 'docusign_dtr/meta_role'
require 'docusign_dtr/meta_room_contact_type'
require 'docusign_dtr/meta_seller_decision_type'
require 'docusign_dtr/meta_special_circumstance_type'
require 'docusign_dtr/meta_state'
require 'docusign_dtr/meta_task_date_type'
require 'docusign_dtr/meta_timezone'
require 'docusign_dtr/meta_transaction_side'
require 'docusign_dtr/office'
require 'docusign_dtr/office'
require 'docusign_dtr/room'
require 'docusign_dtr/task_list'
require 'docusign_dtr/title'
require 'docusign_dtr/profile'
require 'docusign_dtr/region'
require 'docusign_dtr/user'

require 'docusign_dtr/models/address'
require 'docusign_dtr/models/auction_detail'
require 'docusign_dtr/models/auth_config'
require 'docusign_dtr/models/auth_token_response'
require 'docusign_dtr/models/contact'
require 'docusign_dtr/models/creation_detail'
require 'docusign_dtr/models/document'
require 'docusign_dtr/models/lone_wolf_commission'
require 'docusign_dtr/models/lone_wolf_detail'
require 'docusign_dtr/models/member'
require 'docusign_dtr/models/meta'
require 'docusign_dtr/models/meta_activity_type'
require 'docusign_dtr/models/meta_closing_status'
require 'docusign_dtr/models/meta_contact_side'
require 'docusign_dtr/models/meta_country'
require 'docusign_dtr/models/meta_currency'
require 'docusign_dtr/models/meta_financing_type'
require 'docusign_dtr/models/meta_origin_of_lead_type'
require 'docusign_dtr/models/meta_property_type'
require 'docusign_dtr/models/meta_role'
require 'docusign_dtr/models/meta_room_contact_type'
require 'docusign_dtr/models/meta_seller_decision_type'
require 'docusign_dtr/models/meta_special_circumstance_type'
require 'docusign_dtr/models/meta_state'
require 'docusign_dtr/models/meta_task_date_type'
require 'docusign_dtr/models/meta_timezone'
require 'docusign_dtr/models/meta_transaction_side'
require 'docusign_dtr/models/office'
require 'docusign_dtr/models/owner'
require 'docusign_dtr/models/region'
require 'docusign_dtr/models/room_detail'
require 'docusign_dtr/models/task'
require 'docusign_dtr/models/task_list'
require 'docusign_dtr/models/title'
require 'docusign_dtr/models/profile'
require 'docusign_dtr/models/user'
require 'docusign_dtr/models/activity'
require 'docusign_dtr/models/room'

module DocusignDtr
  # Your code goes here...
  DTR_SCOPE = %w[
    dtr.documents.read
    dtr.documents.write
    dtr.rooms.read
    dtr.rooms.write
    dtr.company.read
    dtr.company.write
    dtr.profile.read
    dtr.profile.write
  ].freeze
end
