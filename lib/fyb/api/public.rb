module Fyb
  module API
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
