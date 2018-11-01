# Our ProxyPacParser that use our ProxyPacLoader
class ProxyPacParser < ProxyPacRb::Parser
  def initialize(*args)
    super
    @loader = ProxyPacLoader.new
  end
end
