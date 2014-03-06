module Fyb
  module Middleware
    # Add timestamp to the request
    class Timestamper
      include Rack::Utils

      def initialize(app)
        @app = app
      end

      def call(env)
        body = env['weary.request'].body

        timestamp = "timestamp=#{Time.now.to_i}"
        timestamp = '&' + timestamp if body.length > 0

        env['rack.input'].write(body.string)
        env['rack.input'].write(timestamp)
        env['rack.input'].rewind

        @app.call(env)
      end
    end
  end
end
