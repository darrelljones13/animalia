require 'spec_helper'

describe "Family" do
  let (:family) { FactoryGirl.create :family }

  it 'should be a Family object' do
    expect(family).to be_a(Family)
  end

  it 'should have a :name attribute' do
    expect(family).to respond_to(:name)
  end

  it 'should have an :order_id attribute' do
    expect(family).to respond_to(:order_id)
  end

end