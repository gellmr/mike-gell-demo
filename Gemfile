source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
gem 'pg', '0.15.1'

gem 'mandrill-api'

# Use SCSS for stylesheets
# gem "less-rails", "~> 2.4.2"
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# pagination
gem "kaminari", "~> 0.15.1"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 2.14.1'
  gem "launchy", "~> 2.4.2"
end

# Helpful article:
# https://semaphoreapp.com/blog/2013/08/14/setting-up-bdd-stack-on-a-new-rails-4-application.html
group :test do
  gem "cucumber-rails", "~> 1.4.0", require: false
  gem "database_cleaner", "~> 1.2.0"

  gem "capybara", "~> 2.2.1"
  gem "factory_girl_rails", "~> 4.4.1"
  gem "poltergeist", "~> 1.5.0"
  gem "selenium-webdriver", "~> 2.40.0"

  # NOTE - I needed to add '~/.phantomjs/1.8.1/x86_32-linux/bin'
  # to my PATH... I did this in the file ~/.bashrc
  gem "phantomjs", "~> 1.9.7.0", :require => 'phantomjs/poltergeist'
end

group :production do
  gem 'rails_12factor' # required for heroku
  gem "rack-timeout", "~> 0.0.4"
  gem 'unicorn'
end

# Allow the .env file to store my local config ENV[] vars.
gem "foreman", "~> 0.63.0"

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.2'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

ruby "2.0.0"