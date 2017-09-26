source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'haml-rails', '~> 1.0'
gem 'simple_form', '~> 3.5'
gem 'carrierwave', '~> 1.1'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'jquery-ui-rails'
gem 'kaminari', '~> 1.0', '>= 1.0.1'
gem 'mini_magick'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'devise', '~> 4.3'
gem 'acts_as_list'
gem 'cancancan', '~> 2.0'
gem 'rolify'
gem 'active_model_serializers', '~> 0.10.6'
gem 'aasm', '~> 4.12', '>= 4.12.2'
gem 'bootstrap-datepicker-rails'
gem 'draper', '~> 3.0'
gem 'httparty'
gem 'twitter', '~> 6.1'
gem 'jwt'
# API documentation
gem 'apitome'
gem 'rspec_api_documentation'
# Background processing + web interface for sidekiq
gem 'sidekiq', '~> 5.0', '>= 5.0.4'
gem 'sidekiq-status'
gem 'sidekiq-failures'
gem 'sidekiq-unique-jobs'
gem 'sinatra', require: false
gem 'redis-namespace', '~> 1.5', '>= 1.5.3'
gem 'sidekiq-cron'
gem 'ffaker'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'selenium-webdriver'
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'faker'
  gem 'pry-rails', '~> 0.3.6'
  gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'letter_opener'
  gem 'json-schema'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'capybara-webkit'
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
