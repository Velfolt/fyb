module Fyb
  module API
    # ==== The public API
    #
    # You can access the API directly instead of using Fyb::Client.
    #
    # = Examples
    #
    #   ticker = Fyb.public.ticker.perform.parse
    #   ticker['ask']
    class Public < Weary::Client
      use Middleware::Parser

      domain Fyb::Configuration.domain

      get :ticker, 'ticker.json'
      get :orderbook, 'orderbook.json'
      get :trades, 'trades.json' do |resource|
        resource.optional :since
      end
    end
  end
end
