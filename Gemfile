source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'coffee-rails', '~> 4.2'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.2'
gem 'sass-rails', '~> 5.0'
gem 'sqlite3'
gem 'uglifier', '>= 1.3.0'
# gem 'therubyracer', platforms: :ruby

gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
# gem 'redis', '~> 3.0'
# gem 'bcrypt', '~> 3.1.7'
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'rubocop', require: false
end

group :development do
  gem 'factory_girl_rails', require: false
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'autotest-rails', require: false
  gem 'rails-controller-testing'
  gem 'rspec'
  gem 'rspec-core', '~> 3.5'
  gem 'rspec-expectations', '~> 3.5'
  gem 'rspec-mocks', '~> 3.5'
  gem 'rspec-rails', '~> 3.5'
  gem 'rspec-support', '~> 3.5'
  gem 'simplecov', '0.10.0', require: false
  gem 'simplecov-badge', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
