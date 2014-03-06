require 'hmac-sha1'

module Fyb
  module Middleware
    class Authorize
      def initialize(app)
        @app = app

        @key = Fyb::Configuration.key
        @sig = Fyb::Configuration.sig
      end

      def call(env)
        env.update 'HTTP_SIG' => generate_signature(env), 'HTTP_KEY' => @key

        @app.call(env)
      end

      def generate_signature(env)
        body = env['weary.request'].body.string

        hmac = HMAC::SHA1.new(@sig)
        hmac.update(body)
        hmac.hexdigest
      end
    end
  end
end
