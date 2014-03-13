# Utility functions for BigDecimal
class BigDecimal
  # Returns a rounded to 8 string
  def btc
    round(8).to_s('F')
  end

  # Returns a rounded to 2 string
  def money
    round(2).to_s('F')
  end

  # Returns a BigDecimal with the bitcoin amount converted into real currency
  def in_money(price)
    price = Fyb.ask if price == :ask
    price = Fyb.bid if price == :bid

    self * BigDecimal(price)
  end

  # Returns a BigDecimal with the money amount converted into bitcoin for +price+
  def in_btc(price)
    price = Fyb.ask if price == :ask
    price = Fyb.bid if price == :bid

    self / BigDecimal(price)
  end
end
