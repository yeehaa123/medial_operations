 require 'simplecov'
 SimpleCov.start

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'database_cleaner'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  
  # YEEHAA: added database cleaner
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end
  
  # YEEHAA: include view helpers for testing presenter
  config.include RSpec::Rails::RailsExampleGroup, example_group: {file_path: %r{spec/presenters}}
  config.include ActionView::TestCase::Behavior, example_group: {file_path: %r{spec/presenters}}

  # YEEHAA: using factorygirl implicitly
  config.include FactoryGirl::Syntax::Methods
end