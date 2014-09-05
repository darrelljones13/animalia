require 'spec_helper'

describe "Chlass" do
  let (:chlass) { FactoryGirl.create :chlass }

  it 'should be a Chlass object' do
    expect(chlass).to be_a(Chlass)
  end

  it 'should have a :name attribute' do
    expect(chlass).to respond_to(:name)
  end

  it 'should have a :phylum_id attribute' do
    expect(chlass).to respond_to(:phylum_id)
  end

end