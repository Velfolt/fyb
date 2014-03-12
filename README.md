# Fyb

FYB API v1 implementation.

## Installation

Add this line to your application's Gemfile:

    gem 'fyb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fyb

## Usage

Use the command-line binary to get the current bid/ask price.

```
$ fyb
Bid: 3690.54 Ask: 3870.21

$ fyb --sek
Bid: 3690.54 Ask: 3870.21

$ fyb --sgd
Bid: 3690.54 Ask: 3870.21 # the api currently returns the wrong currency
```

Please look in the source code for documentation or generate rdocs.

A short example follows:

```ruby
require 'rubygems'
require 'fyb'

puts Fyb.ask # default currency is SEK
puts Fyb.bid

# To use the private API you need to authorize
Fyb::Configuration.configure do |config|
  config.currency = :sek # or :sgd
  config.key = 'FYBSE-API-KEY'
  config.sig = 'FYBSE-API-SECRET'
end

Fyb.test # => returns true if authorized

# you can either place an order by doing
order = Fyb.sell! 0.11, Fyb.bid # creates an Order object and performs it
# you can also use the market price
order = Fyb.buy! 0.11, :market

order.cancel! if order.pending?

# or by creating the order and then performing it on your own
order = Fyb::Order.new 0.11, Fyb.ask, :buy
order.perform.cancel!
```

## Contributing

1. Fork it ( http://github.com/Velfolt/fyb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
