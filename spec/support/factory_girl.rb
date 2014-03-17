
RSpec.configure do |config|
  # additional factory_girl configuration

  config.before(:suite) do
    DatabaseCleaner.clean
    FactoryGirl.lint
  end
end