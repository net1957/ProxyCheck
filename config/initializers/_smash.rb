# frozen_string_literal: true

require 'hashie'

# Hashie Mash with symbolized keys
class Smash < Hashie::Mash
  include Hashie::Extensions::Mash::SymbolizeKeys
end
