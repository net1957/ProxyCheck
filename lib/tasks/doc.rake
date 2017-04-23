# frozen_string_literal: true

require 'rdoc/task'

RDoc::Task.new :doc_dev do |rdoc|
  rdoc.rdoc_dir = 'doc/app'
  rdoc.main = 'README.rdoc'
  rdoc.template = ENV['template'] if ENV['template']
  rdoc.title = ENV['title'] || 'DB Presenter Documentation'
  rdoc.options << '--line-numbers'
  rdoc.options << '--charset' << 'utf-8'
  rdoc.options << '--all'
  rdoc.rdoc_files.include('README.rdoc', '*.rb', '*.ru', 'app/**/*.rb', 'lib/**/*.rb')
end

# Rakefile
require 'sdoc' # and use your RDoc task the same way you used it before
require 'rdoc/task' # ensure this file is also required in order to use `RDoc::Task`

RDoc::Task.new :sdoc_dev do |rdoc|
  rdoc.rdoc_dir = 'doc/app' # name of output directory
  rdoc.generator = 'sdoc' # explictly set the sdoc generator
  rdoc.template = 'rails' # template used on api.rubyonrails.org
  rdoc.main = 'README.rdoc'
  rdoc.title = ENV['title'] || 'DB Presenter Documentation'
  rdoc.options << '--line-numbers'
  rdoc.options << '--charset' << 'utf-8'
  rdoc.options << '--all'
  rdoc.rdoc_files.include('README.rdoc', '*.rb', '*.ru', 'app/**/*.rb', 'lib/**/*.rb')
end
