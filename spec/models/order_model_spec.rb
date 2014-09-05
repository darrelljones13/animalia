require 'spec_helper'

describe "Order" do
  let (:order) { FactoryGirl.create :order }

  it 'should be an Order object' do
    expect(order).to be_a(Order)
  end

  it 'should have a :name attribute' do
    expect(order).to respond_to(:name)
  end

  it 'should have a :chlass_id attribute' do
    expect(order).to respond_to(:chlass_id)
  end

end