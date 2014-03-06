module Fyb
  module Middleware
    # Correct the Content-Type of the replies from Fyb
    class Parser
      include Rack::Utils

      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, response = @app.call(env)

        headers = HeaderHash.new(headers)

        if headers.key?('Content-Type') && headers['Content-Type'].include?('text/html; charset=utf-8')
          headers['Content-Type'] = [headers['Content-Type'][0].gsub('text/html', 'application/json')]
        end

        [status, headers, response]
      end
    end
  end
end
