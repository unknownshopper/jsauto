source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

# Rails core
gem 'rails', '~> 6.1.7', '>= 6.1.7.9'
gem 'puma', '~> 5.0'

# Databases
group :development, :test do
  gem 'sqlite3', '~> 1.4'
end

group :production do
  gem 'pg', '~> 1.5'
end

# Assets
gem 'sass-rails', '~> 6.0'
gem 'webpacker', '~> 5.4'
gem 'turbolinks', '~> 5.2'

# JSON APIs
gem 'jbuilder', '~> 2.11'

# Authentication
gem 'bcrypt', '~> 3.1.7'
gem 'devise', '~> 4.9'

# Charts and Date Handling
gem 'chartkick', '~> 5.0'
gem 'groupdate', '~> 6.4'

# Performance
gem 'bootsnap', '~> 1.18', require: false

# Development tools
group :development do
  gem 'web-console', '~> 4.2'
  gem 'rack-mini-profiler', '~> 2.3'
  gem 'listen', '~> 3.8'
  gem 'spring', '~> 4.1'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows compatibility
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
