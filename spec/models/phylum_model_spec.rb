require 'spec_helper'

describe "Phylum" do
  let (:phylum) { FactoryGirl.create :phylum }

  it 'should be a Phylum object' do
    expect(phylum).to be_a(Phylum)
  end

  it 'should have a :name attribute' do
    expect(phylum).to respond_to(:name)
  end

  it 'should have a :kingdom_id attribute' do
    expect(phylum).to respond_to(:kingdom_id)
  end

end