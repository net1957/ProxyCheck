# frozen_string_literal: true

desc 'get Git Branch & Commit'
task :git_version do
  commit = `git rev-parse --short HEAD`.chomp
  branch = /\* (.*)/.match(`git branch --contains #{commit}`.chomp)[1]

  File.open(Rails.root.join('git_version'), 'w') { |f| f.write "#{branch}@#{commit}" }
end
