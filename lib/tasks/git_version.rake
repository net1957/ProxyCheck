# frozen_string_literal: true

desc 'get Git Branch & Commit'
task :git_version do # rubocop:disable Rails/RakeEnvironment
  commit = `git rev-parse --short HEAD`.chomp
  branch = /\* (.*)/.match(`git branch --contains #{commit}`.chomp)[1]

  File.write(Rails.root.join('git_version'), "#{branch}@#{commit}")
end
