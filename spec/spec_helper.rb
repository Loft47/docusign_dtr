require 'simplecov'
require 'coveralls'
Coveralls.wear!
SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]
SimpleCov.start
require 'bundler/setup'
Bundler.setup
require 'webmock/rspec'
require 'docusign_dtr'
