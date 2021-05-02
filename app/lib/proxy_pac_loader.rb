# Our ProxyPacLoader without File loader
class ProxyPacLoader < ProxyPacRb::ProxyPacLoader
  def initialize
    super
    @loaders = []
    @loaders << ProxyPacRb::ProxyPacStringLoader.new
    @loaders << ProxyPacRb::ProxyPacUriLoader.new
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
