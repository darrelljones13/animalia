require 'spec_helper'

describe "User" do
  let (:user) { FactoryGirl.create :user }

  it 'should be a user object' do
    expect(user).to be_a(User)
  end

  it 'should have a :first_name attribute' do
    expect(user).to respond_to(:first_name)
  end

  it 'should have a :last_name attribute' do
    expect(user).to respond_to(:last_name)
  end

  it 'should have an :email attribute' do
    expect(user).to respond_to(:email)
  end

  it 'should have a :password attribute' do
    expect(user).to respond_to(:password)
  end

end