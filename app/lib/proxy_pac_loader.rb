# frozen_string_literal: true

# Our ProxyPacLoader without File loader and patched version of ProxyPacUriLoader
class ProxyPacLoader < ProxyPacRb::ProxyPacLoader
  def initialize
    super
    @loaders = []
    @loaders << ProxyPacRb::ProxyPacStringLoader.new
    @loaders << ProxyPacUriLoader.new
    @loaders << ProxyPacNullLoader.new

    @default_loader = -> { ProxyPacNullLoader.new }
  end
end
