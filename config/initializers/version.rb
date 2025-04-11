# frozen_string_literal: true

# Application version string
#
# inspiration from http://doblock.com/articles/keeping-your-ruby-application-version-in-a-warm-dry-place
module AppVersion
  # major version
  MAJOR = 0
  # minor version
  MINOR = 7
  # tiny version
  TINY = 4

  # @return [String] version string
  def self.to_s
    [MAJOR, MINOR, TINY, git_version].compact.join('.')
  end

  # get git version from file
  def self.git_version
    Rails.root.join('git_version').open('r', &:readline)
  rescue StandardError
    nil
  end
end
