source 'https://rubygems.org'

gem 'rails', '3.2.6'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'haml'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'haml-rails'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'haml-rails'
gem 'jquery-rails'
gem 'devise'
gem 'omniauth-twitter'
gem "omniauth-facebook"
gem "factory_girl_rails"

group :development, :test do
  #https://github.com/bkeepers/dotenv
  #Reads environment variables from a .env file in the project root (.gitignored so secret variables aren't in github)
  gem 'dotenv'
  gem 'rspec-rails'
end

group :test do
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
