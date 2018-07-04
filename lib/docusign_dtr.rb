require 'plissken'
require 'httparty'
require 'virtus'
require 'jwt'

require 'docusign_dtr/version'
require 'docusign_dtr/exceptions'
require 'docusign_dtr/auth/code'
require 'docusign_dtr/auth/jwt'
require 'docusign_dtr/client'
require 'docusign_dtr/office'
require 'docusign_dtr/room'

require 'docusign_dtr/models/auth_config'
require 'docusign_dtr/models/auth_token_response'
require 'docusign_dtr/models/address'
require 'docusign_dtr/models/office'
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
