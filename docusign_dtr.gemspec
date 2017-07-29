# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
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
  spec.cert_chain    = ['certs/shanedavies.pem']
  spec.signing_key   = File.expand_path('~/.ssh/dotloop-private_key.pem') if $PROGRAM_NAME.end_with?('gem')
  spec.required_ruby_version = '~> 2.0'

  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'httparty', '~> 0.13'
  spec.add_runtime_dependency 'virtus', '~> 1.0'
  spec.add_runtime_dependency 'plissken', '~> 0.2'
  spec.add_development_dependency 'simplecov', '~> 0.12'
  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'byebug', '~> 9.0'
  spec.add_development_dependency 'rubocop', '~> 0.41'
  spec.add_development_dependency 'webmock', '~> 2.1'
  spec.add_development_dependency 'travis', '~> 1.8'
end
