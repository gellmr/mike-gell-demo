require 'rspec/expectations'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'phantomjs'

def set_selenium_window_size(width, height)
  window = Capybara.current_session.driver.browser.manage.window
  window.resize_to(width, height)
end

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

if ENV['BROWSER']
  # On demand: non-headless tests via Selenium/WebDriver
  # To run the scenarios in browser (default: Firefox), use the following command line:
  # BROWSER=true bundle exec cucumber
  # or (to have a pause of 1 second between each step):
  # BROWSER=true PAUSE=1 bundle exec cucumber
  Capybara.default_driver = :selenium
  safety_width = 10
  height = 1024
  case ENV['MEDIA']
    when 'xs'
      puts "Testing breakpoint XS"
      set_selenium_window_size(480 - safety_width, height)
    when 'sm'
      puts "Testing breakpoint SM"
      set_selenium_window_size(768 - safety_width, height)
    when 'md'
      puts "Testing breakpoint MD"
      set_selenium_window_size(992 - safety_width, height)
    when 'lg'
      puts "Testing breakpoint LG"
      set_selenium_window_size(1200 - safety_width, height)
    else
      puts "Testing breakpoint XL (this is the default)"
      set_selenium_window_size(1280, height)
  end

  AfterStep do
    sleep (ENV['PAUSE'] || 0).to_i
  end
else
  # DEFAULT: headless tests with poltergeist/PhantomJS
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(
      app,
      # window_size: [1280, 1024]#,
      window_size: [300, 1024]#,
      #debug:       true
    )
  end
  Capybara.default_driver    = :poltergeist
  Capybara.javascript_driver = :poltergeist
end