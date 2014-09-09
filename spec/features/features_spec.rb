require 'spec_helper'

feature 'User Creation' do

  scenario 'User signs up succesfully' do
    visit '/'
    click_on "Create New Account"
    fill_in "user[first_name]", with: "Bob"
    fill_in "user[last_name]", with: "BobBob"
    fill_in "user[email]", with: "Bob@bob.bob"
    fill_in "user[password]", with: "bobbobbob"
    click_on "Submit"
    expect(page).to have_content("My Collections")
  end

  scenario "User doesn't include an email" do 
    visit '/'
    click_on "Create New Account"
    fill_in "user[first_name]", with: "Bob"
    fill_in "user[last_name]", with: "BobBob"
    fill_in "user[password]", with: "bobbobbob"
    click_on "Submit"    
    expect(page).to have_content("Register")
  end

  scenario "User doesn't include a password" do 
    visit '/'
    click_on "Create New Account"
    fill_in "user[first_name]", with: "Bob"
    fill_in "user[last_name]", with: "BobBob"
    fill_in "user[email]", with: "Bob@bob.bob"
    click_on "Submit"
    expect(page).to have_content("Register")
  end

  scenario "New user must have a unique email" do 
    User.create(first_name: "Tom", last_name: "Tom", email: "Bob@bob.bob", password: "password" )
    visit '/'
    click_on "Create New Account"
    fill_in "user[first_name]", with: "Bob"
    fill_in "user[last_name]", with: "BobBob"
    fill_in "user[email]", with: "Bob@bob.bob"
    fill_in "user[password]", with: "bobbobbob"
    click_on "Submit"
    expect(page).to have_content("Register")
  end

end

feature 'User Login' do
  scenario 'an existing user can log in' do
    User.create(first_name: "Bob", last_name: "Bob", email: "Bob@bob.bob", password: "bobbobbob" )
    visit '/'
    fill_in "email", with: "Bob@bob.bob"
    fill_in "password", with: "bobbobbob"
    click_on "Log In"
    expect(page).to have_content("My Collections")
  end
end

feature "User logout" do 
  scenario 'a currently logged in user can log out' do
    User.create(first_name: "Bob", last_name: "Bob", email: "Bob@bob.bob", password: "bobbobbob" )
    visit '/'
    fill_in "email", with: "Bob@bob.bob"
    fill_in "password", with: "bobbobbob"
    click_on "Log In"
    click_on "Logout"
    expect(page).to have_content("Create New Account")
  end
end

feature "Random Animal", js: true do
  scenario 'a user can see a random animal' do
    visit 'localhost:9393'
    click_on "Random Animal"
    expect(page).to have_content("CHORDATA")
  end
end

feature "Instructions", js: true do
  scenario 'a user can access the instructions' do
    visit 'localhost:9393'
    click_on "Instructions"
    expect(page).to have_content("Animalia is a tool that allows you to explore the Animal Kingdom by examining the way scientists name and group animals.")
  end
end

feature "Search", js: true do
  scenario 'a user can access the search function' do
    visit 'localhost:9393'
    click_on "Search"
    find(:css, "#search").should be_visible
  end
end

# feature "Collections" do
#   scenario 'a user add a new collection from the collections page' do
#     @user = User.create(first_name: "Bob", email: "bob@bob.bob", password: "bobbobbob")
#     visit "localhost:9393/users/profile/'#{@user.id}'"
#     fill_in "collection_name", with: "Bobolinks and friends"
#     click_on "New Collection"
#     expect(page).to have_content("Bobolinks and friends")
#   end
# end


