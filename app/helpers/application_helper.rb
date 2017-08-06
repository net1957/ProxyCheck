module ApplicationHelper
  def top_suffix
    "-#{Rails.env}" unless Rails.env.production?
  end

  def top_logo
    ENV['LOGO'] || 'logo_empty.png'
  end
end
