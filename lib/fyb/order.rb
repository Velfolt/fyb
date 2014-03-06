module Fyb
  # Handles a Fyb order.
  #
  #    order = Order.new 1, :market, :buy
  #    order.perform
  #
  # or
  #
  #    order = Order.new 1, 1234, :sell
  #    order.perform
  class Order
    attr_reader :qty, :price, :type, :order_id, :timestamp

    FEE = BigDecimal '0.008'
    ORDER_TYPES = { buy: 'B', sell: 'S', undefined: nil }

    def initialize(qty, price, type, order_id = nil)
      fail ArgumentError, 'type must be :buy or :sell' unless ORDER_TYPES.keys.member? type

      @qty = BigDecimal(qty, 8)
      @price = BigDecimal(price, 2) unless price == :market
      @price ||= price
      @type = ORDER_TYPES[type]
      @order_id = order_id
    end

    def qty_after_fee
      @qty * (BigDecimal(1) - FEE)
    end

    def money_after_fee
      price = @price
      price = @type == 'B' ? Fyb.ask : Fyb.bid if price == :market

      qty_after_fee.in_money(price)
    end

    def perform
      return self unless @order_id.nil? || @type.nil?

      future do
        @price = @type == 'B' ? Fyb.ask : Fyb.bid if @price == :market

        body = Fyb.private.placeorder(qty: @qty.btc, price: @price.money, type: @type).perform.parse
        error = body['error']
        fail Exception, error unless error == 0

        @order_id = body['pending_oid'].to_i

        self
      end
    end

    def cancel!
      return false if @order_id.nil?

      body = Fyb.private.cancelpendingorder(orderNo: @order_id).perform.parse
      error = body['error']
      fail Exception, error unless error == 0

      true
    end

    def pending?
      return false if @order_id.nil?

      body = Fyb.private.getpendingorders.perform.parse
      error = body['error']
      fail Exception, error unless error == 0

      return false if body['orders'].nil?

      body['orders'].each do |order|
        return true if order['ticket'] == @order_id
      end

      false
    end
  end
end
