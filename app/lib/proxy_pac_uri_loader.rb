# frozen_string_literal: true

# our ProxyPacUrLoader monkey patch to encode the response
# TODO: added encode as monkey patch
class ProxyPacUriLoader < ProxyPacRb::ProxyPacUriLoader
  include ProxyPacRb::Encoding

  def load(proxy_pac)
    proxy_pac.content = encode(download_proxy_pac(proxy_pac.source.to_s))
    proxy_pac.type = :url
  end
end
