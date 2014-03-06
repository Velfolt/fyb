require 'weary'
require 'json'
require 'future'

require 'fyb/version'
require 'fyb/configuration'
require 'fyb/middleware/authorize'
require 'fyb/middleware/parser'
require 'fyb/api/public'
require 'fyb/api/private'

module Fyb
  extend self

  class << self
    def public
      @public ||= API::Public.new
      @public
    end

    def private
      @private ||= API::Private.new
      @private
    end

    def ask
      public.ticker.perform.parse['ask']
    end

    def bid
      public.ticker.perform.parse['bid']
    end

    def test
      p private.test.perform.parse
      true
    end
  end
end
