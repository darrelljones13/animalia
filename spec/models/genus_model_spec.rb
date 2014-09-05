require 'spec_helper'

describe "Genus" do
  let (:genus) { FactoryGirl.create :genus }

  it 'should be a Genus object' do
    expect(genus).to be_a(Genus)
  end

  it 'should have a :name attribute' do
    expect(genus).to respond_to(:name)
  end

  it 'should have a :family_id attribute' do
    expect(genus).to respond_to(:family_id)
  end

end