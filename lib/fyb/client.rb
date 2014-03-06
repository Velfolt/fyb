module Fyb
  # Client class containing all the methods needed to buy and sell btc.
  class Client
    # Returns the current ask price.
    def ask
      BigDecimal Fyb.public.ticker.perform.parse['ask'], 2
    end

    # Returns the current bid price.
    def bid
      BigDecimal Fyb.public.ticker.perform.parse['bid'], 2
    end

    # Returns a couple of the last asks and bids.
    def orderbook
      Fyb.public.orderbook.perform.parse
    end

    # Returns trades.
    #
    #   Fyb.trades
    #   Fyb.trades Time.now.to_i
    #
    # * +tid+ tradeid to begin history from
    def trades(tid = nil)
      params = { since: tid } unless tid.nil?
      params ||= {}

      plain_orders = Fyb.public.trades(params).perform.parse

      return [] if plain_orders.empty?

      plain_orders.map do |data|
        Order.new data['amount'], data['price'], :undefined, data['tid']
      end
    end

    # Returns true if the authorization key and signature was correct.
    def test
      data = Fyb.private.test.perform.parse
      data['msg'] == 'success'
    end

    # Creates and performs a buy order.
    #
    # Returns the order.
    def buy!(qty, price)
      order = Fyb::Order.new qty, price, :buy
      order.perform
    end

    # Creates and performs a sell order.
    #
    # Returns the order.
    def sell!(qty, price)
      order = Fyb::Order.new qty, price, :sell
      order.perform
    end

    # Returns your currenct balance and the currency you have configured.
    def balance
      wallet = Fyb.private.getaccinfo.perform.parse
      btc_label = 'btcBal'
      money_label = Fyb::Configuration.currency.to_s + 'Bal'

      btc = BigDecimal.new wallet[btc_label]
      real_money = BigDecimal.new wallet[money_label]

      { :btc => btc, Fyb::Configuration.currency => real_money }
    end

    # Returns your order history.
    def order_history(limit = 10)
      plain_orders = Fyb.private.getorderhistory(limit: limit).perform.parse
      error = plain_orders['error']

      fail Exception, error unless error == 0

      plain_orders['orders'].map do |data|
        Order.new data['qty'], data['price'], data['type'] == 'B' ? :buy : :sell, data['ticket']
      end
    end
  end
end
