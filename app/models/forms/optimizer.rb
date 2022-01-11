require 'ipaddr'

module Forms
  # Optimize scripts
  class Optimizer
    include ActiveModel::Model

    attr_accessor :name
    attr_reader :result

    validates :name, presence: true, unless: :proxies_fixed?
    validates :name, inclusion: { in: proc { ProxyList.all.map(&:value) } }, if: :proxies_fixed?
    validate :script_valid?, if: ->(e) { e.errors.empty? }
    validate :optimize, if: ->(e) { e.errors.empty? }

    # Set @return to compressed script
    # @return [String] compressed script
    def optimize
      opts = { output: { beautify: false }, mangle: true, harmony: true }
      @result = ProxyPacRb::ProxyPacCompressor.new(options: opts).compress(script)
    rescue StandardError, Uglifier::Error => e
      errors.add(:name, "Script invalid: #{e.message}")
    end

    private

    # @return [ProxyPacRb::ProxyPacxxx]
    # memoize it
    def script
      @script ||= Parser.new.call(name: name)
    end

    # validate the script
    def script_valid?
      errors.add(:name, script.message) unless script.valid
    end

    def proxies_fixed?
      ProxyList.all.any?
    end
  end
end
