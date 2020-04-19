# Patch from https://github.com/net1957/ProxyCheck/network/alert/Gemfile.lock/actionview/open
# correct bug GHSA-65cv-r6x7-79hv in rails 5.1
# Corrected in Rails 5.2.4.2 and 6.0.2.2
# Supress this file if you install Rails greater than 5.2.4.2 or 6.0.2.2
ActionView::Helpers::JavaScriptHelper::JS_ESCAPE_MAP.merge!(
  {
    "`" => "\\`",
    "$" => "\\$"
  }
)

module ActionView::Helpers::JavaScriptHelper
  alias :old_ej :escape_javascript
  alias :old_j :j

  def escape_javascript(javascript)
    javascript = javascript.to_s
    if javascript.empty?
      result = ""
    else
      result = javascript.gsub(/(\\|<\/|\r\n|\342\200\250|\342\200\251|[\n\r"']|[`]|[$])/u, JS_ESCAPE_MAP)
    end
    javascript.html_safe? ? result.html_safe : result
  end

  alias :j :escape_javascript
end
