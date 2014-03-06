module Fyb
  module Configuration
    extend self

    attr_accessor :key, :sig, :currency

    APIS = {
      :sek => 'https://www.fybse.se/api/SEK/',
      :sgd => 'https://www.fybsg.com/api/SGD/',
      :test => 'https://fyb.apiary.io/'
    }

    def domain
      return APIS[:sek] if self.currency == nil

      APIS[self.currency]
    end

    def configure
      yield self
    end
  end
end
