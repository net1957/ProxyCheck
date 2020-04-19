# parse a script
class Parser
  # @return [ProxyPacRb::ProxyPacxxx]
  # use name accessor (script or script url)
  # use ip accessor as string
  def call(name:, ip: nil)
    env = ip.blank? ? ProxyPacRb::Environment.new : ProxyPacRb::Environment.new(client_ip: ip)
    ProxyPacParser.new(environment: env)
                  .parse(name)
    #             .tap { |script| Rails.logger.debug { script.inspect } }
  end
end
