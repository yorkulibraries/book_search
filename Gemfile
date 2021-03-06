source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

## BASE RAILS
gem 'rails', '~> 5.1.6.1'

## DATABASES
gem 'sqlite3'
gem 'mysql2'

## CSS AND JavaScript
gem 'sass-rails', '~> 5.0'
#gem 'bootstrap', '~> 4.0.0'
gem "bootstrap", ">= 4.1.2"
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'mini_racer'#, platforms: :ruby

# SECURITY UPDATES -> will probably be removed after rails upgrade
gem "sprockets", ">= 3.7.2"
gem "rubyzip", ">= 1.2.2"
gem "loofah", ">= 2.2.3"
gem "rails-html-sanitizer", "1.0.4"
gem "ffi", ">= 1.9.24"
gem "rack", ">= 2.0.6"

## TRIX Editor
gem 'trix'

## SETTINGS
gem "rails-settings-cached", "0.7.2"

## TOOLS AND HELPERS
gem "nokogiri", "1.8.5"
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'liquid', "4.0.3"
#gem 'redis', '~> 3.0'
#gem 'bcrypt', '~> 3.1.7'

gem 'simple_form', "4.0.0"
#gem "font-awesome-rails", "4.7.0.4" ## Font-Icons
gem 'font-awesome-sass', '~> 5.6.1'

gem "chunky_png", "1.3.10"
gem "barby", "0.6.5"

## For paging of view data. Rubygem outdated at 0.17. Needed to use github @ 1.1.1
gem 'kaminari', :git => 'https://github.com/kaminari/kaminari'


## DEPLOYMENT
gem 'puma', '~> 3.7'

# Use Capistrano for deployment
#gem 'capistrano-rails', "1.4.0", group: :development



### DEVELOPMENT AND TESTING ####

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'

  ## FACTORY BOT (Formerly known as FactoryGirl)
  gem 'factory_bot_rails', "4.8.2"

  gem 'shoulda', "3.5"
  gem 'shoulda-matchers'
  gem 'shoulda-context'
  gem "mocha", require: false
  gem "ruby-prof", "0.16.2"
  gem 'database_cleaner', "1.6.1"

  gem 'guard', "2.14.2" # NOTE: this is necessary in newer versions
  gem 'guard-minitest'

  gem 'faker', '1.8.7'
  gem 'populator', git: "https://github.com/norikt/populator.git"

  #gem 'minitest-rails-capybara'

  ## FIX Readline error with version 6 as version 7 is installed by homebrew
  gem 'rb-readline'

  # gem 'sassc'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem "better_errors", group: :development
  gem "binding_of_caller", group: :development
end

###### Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
