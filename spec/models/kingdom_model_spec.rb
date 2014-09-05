require 'spec_helper'

describe "Kingdom" do
  let (:kingdom) { FactoryGirl.create :kingdom }

  it 'should be a Kingdom object' do
    expect(kingdom).to be_a(Kingdom)
  end

  it 'should have a :name attribute' do
    expect(Kingdom).to respond_to(:name)
  end
end