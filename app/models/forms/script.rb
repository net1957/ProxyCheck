require 'ipaddr'

module Forms
  # hold the interface to ProxyPacRb
  class Script
    include ActiveModel::Model

    attr_accessor :ip, :name, :url

    validate :ip_valid?
    validates :name, presence: true, unless: :url_fixed?
    validates :name, inclusion: { in: proc { ProxyList.all.map(&:value) } }, if: :url_fixed?
    validate :script_valid?, if: :ip_valid?

    # @return [Array] of Hash(url:, result:)
    def proxies
      url.split.each_with_object([]) do |l_url, a|
        a << { url: l_url, result: proxy(l_url) }
      end
    end

    private

    # @return [String] script result for url and ip
    def proxy(url)
      script.find(url)
    end

    # @return [ProxyPacRb::ProxyPacxxx]
    # memoize it
    def script
      @script ||= Parser.new.call(name: name, ip: ip)
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
      ProxyList.all.any?
    end
  end
end
