# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby file: '.ruby-version'

gem 'json', '>= 2.10.2'

gem 'nokogiri', '>=1.6.7', '<1.18'

# for proxy
gem 'mini_racer', '~>0.16.0'

gem 'proxy_pac_rb', github: 'net1957/proxy_pac_rb', branch: 'miniracer'

# for forms
gem 'simple_form', '~>5.0'

# to access configuration
gem 'hashie', '~>5.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~>8.0.1'

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
gem 'tzinfo-data', platforms: %i[windows jruby]

# bundle exec rails redoc_dev generates the API under doc/app.
gem 'sdoc', group: :doc

# TODO: check if needed in future gems update
# gems suppressed from standard library in ruby 3.5.0 (to suppress deprecation warning at startup)
gem 'ostruct'

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
  gem 'puma'
end
