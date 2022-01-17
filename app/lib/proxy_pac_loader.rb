# frozen_string_literal: true

# Our ProxyPacLoader without File loader and patched version of ProxyPacUri1Loader
class ProxyPacLoader < ProxyPacRb::ProxyPacLoader
  def initialize
    super
    @loaders = []
    @loaders << ProxyPacRb::ProxyPacStringLoader.new
    @loaders << ProxyPacUri1Loader.new
    @loaders << ProxyPacNullLoader.new

    @default_loader = -> { ProxyPacNullLoader.new }
  end
end

# Our ProxyPacNullLoader to add message to exception
class ProxyPacNullLoader < ProxyPacRb::ProxyPacNullLoader
  def load(proxy_pac)
    proxy_pac.type = :null

    raise StandardError, 'URL or script is not valid'
  end
end

# our ProxyPacUriLoader monkey patch to encode the response
# TODO: added encode as monkey patch
class ProxyPacUri1Loader < ProxyPacRb::ProxyPacUriLoader
  include ProxyPacRb::Encoding
  def load(proxy_pac)
    proxy_pac.content = encode(download_proxy_pac(proxy_pac.source.to_s))
    proxy_pac.type = :url
  end
end
