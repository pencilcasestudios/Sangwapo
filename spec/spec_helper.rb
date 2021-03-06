require "rubygems"
require "spork"

Spork.prefork do
  ENV["RAILS_ENV"] ||= "test"
  require File.expand_path("../../config/environment", __FILE__)
  require "rspec/rails"
  require "rspec/autorun"
  require "capybara/rspec"

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.include(EmailerMacros)  
    config.before(:each) { reset_email }  
  end
end

Spork.each_run do
  FactoryGirl.reload
  I18n.reload!
  load "#{Rails.root}/config/routes.rb"
end
