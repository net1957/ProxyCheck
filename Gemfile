# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>=3.0.0'

# for proxy
gem 'mini_racer', '~>0.6.0'
gem 'proxy_pac_rb', github: 'net1957/proxy_pac_rb', branch: 'miniracer'

# for forms
gem 'simple_form', '~>5.0'

# to access configuration
gem 'hashie', '~>5.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.0'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
# gem "jsbundling-rails"

# SK importmap
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# bundle exec rails redoc_dev generates the API under doc/app.
gem 'sdoc', group: :doc

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # to lint ruby
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  # Use Puma as the app server
  gem 'puma', '~> 5.6'
end
