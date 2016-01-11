require 'rubygems'
require 'database_cleaner'
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara-screenshot/rspec' # Capybara::Screenshot.screenshot_and_save_page

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
    config.include Rails.application.routes.url_helpers
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.order = "random"

  config.include Capybara::DSL, type: :feature
  config.include FactoryGirl::Syntax::Methods, type: :feature
  config.include RSpec::Rails::RequestExampleGroup, type: :feature
  Capybara::Screenshot.autosave_on_failure = false
  config.before :each do
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction
    else
      DatabaseCleaner.strategy = :truncation
    end
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end
