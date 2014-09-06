require 'spec_helper'


describe "home" do

    it "should render the home page" do
       visit "/"

       page.should have_content("Animalia")
    end

end