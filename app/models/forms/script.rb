# frozen_string_literal: true

require 'ipaddr'

module Forms
  # hold the interface to ProxyPacRb
  class Script
    include ActiveModel::Model

    attr_accessor :ip, :name, :url

    validate :ip_valid?
    validates :name, presence: true, unless: :proxies_fixed?
    validates :name, inclusion: { in: proc { ProxyList.all.map(&:value) } }, if: :proxies_fixed?
    validates :url, presence: true
    validate :script_valid?, if: ->(e) { e.errors.empty? }

    # @return [Array] of Hash(url:, result:)
    def proxies
      url.split.each_with_object([]) do |l_url, a|
        a << { url: l_url, result: proxy(l_url) }
      end
    end

    private

    # @return [String] script result for url and ip
    def proxy(url)
      parser.find(url)
    end

    # @return [ProxyPacRb::ProxyPacxxx]
    # memoize it
    def parser
      @parser ||= Parser.new.call(name: name, ip: ip)
    end

    # validate the script
    def script_valid?
      errors.add(:name, parser.message) unless parser.valid
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

    def proxies_fixed?
      ProxyList.all.any?
    end
  end
end
