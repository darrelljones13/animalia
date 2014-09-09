require 'rubygems'

# All our specs should require 'spec_helper' (this file)

# If RACK_ENV isn't set, set it to 'test'.  Sinatra defaults to development,
# so we have to override that unless we want to set RACK_ENV=test from the
# command line when we run rake spec.  That's tedious, so do it here.
ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'shoulda-matchers'
require 'rack/test'
require 'capybara'
require 'capybara/rspec'
require 'factory_girl'
require 'factories'
require 'faker'
require 'database_cleaner'
require 'capybara/webkit/matchers'

       
Capybara.configure do |config|
  config.run_server = false
end
       
Capybara.javascript_driver = :selenium
Capybara.app = Sinatra::Application.new

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Capybara::DSL
  # config.include Factory::Syntax::Methods
  config.include(Capybara::Webkit::RspecMatchers, :type => :feature)

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end

def app
  Sinatra::Application
end
