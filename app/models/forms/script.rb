require 'ipaddr'

module Forms
  # hold the interface to PoxyPacRb
  class Script
    include ActiveModel::Model

    attr_accessor :ip, :name, :action, :url
    attr_reader :script

    validate :ip_valid?
    validates :name, presence: true
    validates :action, inclusion: { in: %w[validate compress url] }
    validate :script_valid?, if: :ip_valid?

    # @return [String] script result for url and ip
    def proxy(url)
      script.find(url)
    end

    def compress
      ProxyPacRb::ProxyPacCompressor.new.compress(script)
    end

    private

    def script_valid?
      errors.add(:name, script.message) unless p_script(ip).valid
    end

    def p_script(ip = nil)
      env = ip.blank? ? ProxyPacRb::Environment.new : ProxyPacRb::Environment.new(client_ip: ip)
      @script = ProxyPacRb::Parser.new(environment: env).parse(name).tap { |script| Rails.logger.debug { script.inspect } }
    end

    # validate that ip is a valid IPV4 address
    # @return [Object] ip as validated string, false or true if blank
    def ip_valid?
      return true if ip.blank?
      IPAddr.new(ip.strip, Socket::AF_INET).to_s
    rescue IPAddr::InvalidAddressError, IPAddr::AddressFamilyError
      errors.add(:ip, :invalid)
      false
    end
  end
end
