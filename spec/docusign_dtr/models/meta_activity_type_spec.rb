require_relative '../../spec_helper'

RSpec.describe DocusignDtr::Models::MetaActivityType do
  let(:client) { double }
  subject do
    meta = DocusignDtr::Models::MetaActivityType.new(
      id: 'string',
      name: 'Test Meta',
      display_order: 0
    )
    meta.client = client
    meta
  end
  let(:attr) do
    %i[
      id name display_order
    ]
  end

  describe '#attributes' do
    it { expect(subject.attributes.keys).to eq(attr) }
  end
end
