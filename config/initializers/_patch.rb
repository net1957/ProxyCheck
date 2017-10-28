# patch to correct utf8 string wrongly encoded as ASCII-8BIT and suppress file system proxy load
# tested on linux with ruby 2.2.7-p470
module ProxyPacRb
  # Encodes strings as UTF-8
  module Encoding
    def encode(string)
      if string.encoding.name == 'ASCII-8BIT'
        data = string.dup
        data.force_encoding('UTF-8')

        unless data.valid_encoding?
          raise ::Encoding::UndefinedConversionError, "Could not encode ASCII-8BIT data #{string.dump} as UTF-8"
        end
      else
        data = string.encode('UTF-8')
      end
      data
    end
  end

  # Dump Proxy pac to file system
  class ProxyPacLoader
    def initialize
      @loaders = []
      @loaders << ProxyPacStringLoader.new
      @loaders << ProxyPacUriLoader.new
      # @loaders << ProxyPacFileLoader.new
      @loaders << ProxyPacNullLoader.new

      @default_loader = -> { ProxyPacNullLoader.new }
    end
  end
  # Handle proxy pac == nil
  class ProxyPacNullLoader
    def load(proxy_pac)
      proxy_pac.type = :null

      raise StandardError, 'URL or script is not valid'
    end

    def suitable_for?(proxy_pac)
      proxy_pac.nil?
    end
  end
end
