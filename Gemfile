source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

## BASE RAILS
gem 'rails', '~> 5.1.4'

## DATABASES
gem 'sqlite3'

## CSS AND JavaScript
gem 'sass-rails', '~> 5.0'
gem 'bootstrap', '~> 4.0.0'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'therubyracer', platforms: :ruby

## TOOLS AND HELPERS
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
#gem 'redis', '~> 3.0'
#gem 'bcrypt', '~> 3.1.7'

## DEPLOYMENT
gem 'puma', '~> 3.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development



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

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'


end

###### Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
