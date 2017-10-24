module ApplicationHelper
  def top_suffix
    "-#{Rails.env}" unless Rails.env.production?
  end

  def top_logo
    ENV['LOGO'] || 'logo_empty.png'
  end

  def compress_button
    unless ENV['NO_COMPRESS_BUTTON']
      '<input id="compress" class="hide button tiny secondary no-margin float-right" data-disable-with="Wait..." value="Compress script" type="submit">'
    end
  end
end
