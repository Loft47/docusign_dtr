lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'docusign_dtr/version'

Gem::Specification.new do |spec|
  spec.name          = 'docusign_dtr'
  spec.version       = DocusignDtr::VERSION
  spec.authors       = ['Loft47']
  spec.email         = ['support@loft47.com']

  spec.summary       = %(Docusign DTR library)
  spec.description   = %(Ruby library for Docusign DTR rest API)
  spec.homepage      = %(http://github.com/Loft47/docusign_dtr)
  spec.license       = 'MIT'
  spec.cert_chain    = ['certs/gem-public_cert.pem']
  spec.signing_key   = File.expand_path('~/.ssh/gem-private_key.pem') if $PROGRAM_NAME.end_with?('gem')
  spec.required_ruby_version = '~> 3.2.2'

  raise 'RubyGems 2.5 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'httparty', '~> 0.20'
  spec.add_runtime_dependency 'jwt', '~> 2.1'
  spec.add_runtime_dependency 'plissken', '~> 2'
  spec.add_runtime_dependency 'virtus', '~> 1.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
