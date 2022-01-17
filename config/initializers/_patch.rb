# frozen_string_literal: true

# patch to correct utf8 string wrongly encoded as ASCII-8BIT
# tested on linux with ruby 2.2.7-p470 and 2.3.4-p301
module ProxyPacRb
  # Encodes strings as UTF-8
  module Encoding
    def encode(string)
      if string.encoding.name == 'ASCII-8BIT'
        data = string.dup
        data.force_encoding('ISO-8859-1').encode('UTF-8', invalid: :replace, undef: :replace)

        unless data.valid_encoding?
          raise(::Encoding::UndefinedConversionError, "Could not encode ASCII-8BIT data as ISO-8859-1 then to UTF-8: #{string.dump}") # rubocop:disable Layout/LineLength
        end
      else
        data = string.encode('UTF-8', invalid: :replace, undef: :replace)
      end
      data
    end
  end
end
