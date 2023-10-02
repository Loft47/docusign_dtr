require 'simplecov'
require 'coveralls'
SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]
SimpleCov.start
# Coveralls.wear!
require 'bundler/setup'
Bundler.setup
require 'pry'
require 'webmock/rspec'
require_relative 'helpers/webmocks'

ROOT = Pathname.new(Gem::Specification.find_by_name('docusign_dtr').gem_dir).freeze
require 'docusign_dtr'

RSpec.configure do |conf|
  conf.include Helpers
end
