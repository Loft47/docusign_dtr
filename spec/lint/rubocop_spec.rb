require_relative '../spec_helper'

RSpec.describe 'Files should have correct syntax' do
  let(:report) { `rubocop` }

  it { expect(report).to include 'no offenses detected' }
end
