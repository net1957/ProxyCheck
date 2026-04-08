# frozen_string_literal: true

# Our ProxyPacNullLoader to add message to exception
class ProxyPacNullLoader < ProxyPacRb::ProxyPacNullLoader
  def load(proxy_pac)
    proxy_pac.type = :null

    raise StandardError, 'URL or script is not valid'
  end
end
