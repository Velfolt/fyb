module Fyb
  # Configuration class that sets the default values if needed. Call this using:
  #
  #    Fyb::Configuration.configure do |config|
  #      config.currency = :sek
  #      config.key = 'your-fyb-key'
  #      config.sig = 'your-fyb-secret'
  #    end
  module Configuration
    module_function

    class << self
      attr_accessor :key, :sig, :currency

      APIS = {
        sek: 'https://www.fybse.se/api/SEK/',
        sgd: 'https://www.fybsg.com/api/SGD/',
        test: 'https://fyb.apiary.io/'
      }

      def currency
        @currency ||= :sek
        @currency
      end

      def domain
        return APIS[:sek] if currency.nil?

        APIS[currency]
      end

      def configure
        yield self
      end
    end
  end
end
