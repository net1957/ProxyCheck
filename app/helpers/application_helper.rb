module ApplicationHelper
  def top_suffix
    "-#{Rails.env}" unless Rails.env.production?
  end
end
