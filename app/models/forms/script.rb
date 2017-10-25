require 'ipaddr'

module Forms
  # hold the interface to ProxyPacRb
  class Script
    include ActiveModel::Model

    attr_accessor :ip, :name, :action, :url

    validate :ip_valid?
    validates :name, presence: true, unless: :url_fixed?
    validates :name, inclusion: { in: proc { ProxyList.all.map { |e| e[:value] } } }, if: :url_fixed?
    validates :action, inclusion: { in: %w[compress url] }
    validate :script_valid?, if: :ip_valid?

    # @return [Array] of Hash(url:, result:)
    def proxies
      url.split.each_with_object([]) do |l_url, a|
        a << { url: l_url, result: proxy(l_url) }
      end
    end

    # @return [Object] compressed script
    def compress
      ProxyPacRb::ProxyPacCompressor.new.compress(script)
    end

    private

    # @return [String] script result for url and ip
    def proxy(url)
      script.find(url)
    end

    # @return [ProxyPacRb::Parser]
    # memoize it
    def script
      @script ||= generate_script
    end

    # @return [ProxyPacRb::Parser]
    # use ip accessor
    # use name accessor
    def generate_script
      env = ip.blank? ? ProxyPacRb::Environment.new : ProxyPacRb::Environment.new(client_ip: ip)
      ProxyPacRb::Parser.new(environment: env)
                        .parse(name)
      #                 .tap { |script| Rails.logger.debug { script.inspect } }
    end

    # validate the script
    def script_valid?
      errors.add(:name, script.message) unless script.valid
    end

    # validate that ip is a valid IPV4 address
    # @return [Binary] true or false
    def ip_valid?
      return true if ip.blank?
      IPAddr.new(ip.strip, Socket::AF_INET) && true
    rescue IPAddr::InvalidAddressError, IPAddr::AddressFamilyError
      errors.add(:ip, :invalid)
      false
    end

    def url_fixed?
      ProxyList.all
    end
  end
end
