require 'ipaddr'

module Forms
  # Optimize scripts
  class Optimizer
    include ActiveModel::Model

    attr_accessor :name

    validates :name, presence: true, unless: :url_fixed?
    validates :name, inclusion: { in: proc { ProxyList.all.map(&:value) } }, if: :url_fixed?
    validate :script_valid?

    # @return [Object] optimised script
    def optimize
      opts = { output: { beautify: false }, mangle: true }
      ProxyPacRb::ProxyPacCompressor.new(options: opts).compress(script)
    end

    private

    # @return [ProxyPacRb::Parser]
    # memoize it
    def script
      @script ||= generate_script
    end

    # @return [ProxyPacRb::Parser]
    # use name accessor
    def generate_script
      ProxyPacParser.new(environment: ProxyPacRb::Environment.new)
                        .parse(name)
      #                 .tap { |script| Rails.logger.debug { script.inspect } }
    end

    # validate the script
    def script_valid?
      errors.add(:name, script.message) unless script.valid
    end

    def url_fixed?
      ProxyList.all.any?
    end
  end
end
