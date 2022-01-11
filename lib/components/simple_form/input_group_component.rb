# custom component
# permit to pass a html string wrapped bay a  div .control
module InputAddons
  def addons(_wrapper_options = nil)
    # INFO: security: we assume that addons is not a user input
    template.content_tag(:div, options[:addons]&.to_s&.html_safe, class: 'control') # rubocop:disable Rails/OutputSafety
  end
end

# Register the component in Simple Form.
SimpleForm.include_component(InputAddons)
