require 'weary'
require 'json'
require 'future'
require 'stringio'
require 'bigdecimal'

require 'fyb/version'
require 'fyb/client'
require 'fyb/configuration'
require 'fyb/order'
require 'fyb/middleware/authorize'
require 'fyb/middleware/parser'
require 'fyb/middleware/timestamper'
require 'fyb/api/public'
require 'fyb/api/private'
require 'fyb/util/bigdecimal'

# Fyb is an implementation of the FYB v1 API.
module Fyb
  module_function

  class << self
    def public
      @public ||= API::Public.new
      @public
    end

    def private
      @private ||= API::Private.new
      @private
    end

    def client
      @client ||= Fyb::Client.new
      @client
    end

    def method_missing(method, *args, &block)
      client.send(method, *args, &block)
    end
  end
end
