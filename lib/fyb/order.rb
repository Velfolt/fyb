module Fyb
  class Order
    attr_reader :qty, :price, :type, :order_id, :timestamp

    ORDER_TYPES = { :buy => 'B', :sell => 'S' }

    def initialize(qty, price, type)
      raise(ArgumentError, 'type must be :buy or :sell') unless ORDER_TYPES.keys.member? type

      @qty = qty
      @price = price
      @type = ORDER_TYPES[type]
    end

    def perform
      return self if @order_id.nil?

      future do
        response = Fyb.private.placeorder(:qty => @qty, :price => @price, :type => @type).perform
        raise(Exception, 'placeorder not successful') unless response.success?

        body = response.body
        raise(Exception, 'error in response') if body['error'] != 0

        @order_id = body['pending_oid']

        self
      end
    end

    def cancel!
      return self if @order_id.nil?

      Fyb.private.cancelpendingorder(:orderNo => @order_id).perform
    end
  end
end
