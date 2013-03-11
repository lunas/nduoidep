
source 'https://rubygems.org'

gem 'rails' #, '3.2.6'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'rake' #, '0.8.7'  # version 0.9.2 somehow broken, according to stackoverflow

gem 'haml'
gem 'ffaker'
gem "html_truncator", "~>0.2"
gem 'sanitize'
gem 'awesome_print'
gem 'simple_form'
gem 'typus'
gem 'cancan'
gem 'decent_exposure'
gem 'kaminari'

gem 'hpricot'
gem 'ruby_parser'

gem 'carrierwave'
gem "fog", "~> 1.3.1"


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'haml-rails'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'compass-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'haml-rails'
#gem 'omniauth-twitter'
#gem "omniauth-facebook"
gem "factory_girl_rails"

gem 'devise'
gem 'cloudfoundry-devise', :require => 'devise'

group :development, :test do
  #https://github.com/bkeepers/dotenv
  #Reads environment variables from a .env file in the project root (.gitignored so secret variables aren't in github)
  gem 'dotenv'
  gem 'rspec-rails'
  gem 'sqlite3'
  gem 'jquery-rails'
end

group :test do
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
  gem 'cloudfoundry-jquery-rails'
end

# Background workers talking to redis server
# gem 'resque', :require => 'resque/server'

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

# This comment may be pulled from another fork. Yum!

