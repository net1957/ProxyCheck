# manage proxy list
class ProxyList
  class << self
    # @return [Array] of Smash (memoized)
    def all
      @all = load_records unless defined?(@all)
      @all || []
    end

    private

    # load and decode PROXIES env variable
    def load_records
      load_env&.each_with_object([]) do |entry, acc|
        name, url = entry.split(';')
        text = "#{name} | #{url}"
        acc << Smash.new(label: text, value: url)
      end
    end

    def load_env
      ENV['PROXIES']&.split(',')
    end
  end
end
