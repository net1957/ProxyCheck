# frozen_string_literal: true

require 'sdoc'
require 'rdoc/task'

RDoc::Task.new  do |rdoc|
  rdoc.rdoc_dir = 'doc/app'
  rdoc.main = 'README.rdoc'
  rdoc.template = ENV['template'] if ENV['template']
  rdoc.title = ENV.fetch('title', 'ProxyCheck Documentation')
  rdoc.options << '--format=darkfish'
  rdoc.options << '--line-numbers'
  rdoc.options << '--charset' << 'utf-8'
  rdoc.options << '--all'
  rdoc.rdoc_files.include('README.rdoc', '*.rb', '*.ru', 'app/**/*.rb', 'lib/**/*.rb')
end
