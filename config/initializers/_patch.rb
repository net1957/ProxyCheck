# patch to correct utf8 string wrongly encoded as ASCII-8BIT
# tested on linux with ruby 2.2.7-p470 and 2.3.4-p301
module ProxyPacRb
  # Encodes strings as UTF-8
  module Encoding
    def encode(string)
      if string.encoding.name == 'ASCII-8BIT'
        data = string.dup
        data.force_encoding('UTF-8')

        raise(::Encoding::UndefinedConversionError, "Could not encode ASCII-8BIT data #{string.dump} as UTF-8") unless data.valid_encoding?
      else
        data = string.encode('UTF-8')
      end
      data
    end
  end
end
