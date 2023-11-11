# frozen_string_literal: true

# Helpers used in views
module ApplicationHelper
  def top_suffix
    "-#{Rails.env}" unless Rails.env.production?
  end

  def top_logo
    ENV.fetch('LOGO', 'logo_empty.png')
  end

  def compress?
    ENV['NO_COMPRESS_BUTTON'] ? false : true
  end

  def proxy_list
    ProxyList.entries
  end
end
