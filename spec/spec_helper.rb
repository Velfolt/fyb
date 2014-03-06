$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'fyb'

def response(rawJson)
  Weary::Response.new(rawJson,
                      200,
                      'Content-Type' => 'application/json')
end

def verify(object)
  RSpec::Mocks.proxy_for(object).verify
end

def reset(object)
  RSpec::Mocks.proxy_for(object).reset
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

class JsonData
  class << self
    def ticker
      response('{"ask":3500.00,"bid":3600.00}')
    end

    def orderbook
      response('{"asks":[["1194.90","0.50000000"],["1195.00","0.17295600"],["1198.80","1.25000000"]],"bids":[["1127.00","1.03075421"],["1126.10","2.00000000"],["1106.00","0.50000000"],["1105.50","1.24000000"]]}')
    end

    def test_success
      response('{"error":0,"msg":"success"}')
    end

    def test_fail
      response('{"error":0,"msg":"unsuccessful"}')
    end

    def order
      response('{"error":0, "msg":"", "pending_oid":"28"}')
    end

    def cancelpendingorder
       response('{"error":0}')
    end

    def getpendingorders
      response('{"error":0,"orders":[{"date":1387099682,"price":"5.00","qty":"0.99000000","ticket":28,"type":"S"},{"date":1386932631,"price":"2.00","qty":"0.99000000","ticket":5,"type":"B"},{"date":1386099367,"price":"1.00","qty":"1.00000000","ticket":4,"type":"B"}]}')
    end

    def trades
      response('[{"amount":"1.00000000","date":1386935056,"price":"1161.00","tid":27350},{"amount":"0.18000000","date":1386937603,"price":"1161.00","tid":27372},{"amount":"0.01651380","date":1386937959,"price":"1127.00","tid":27379}]')
    end

    def getaccinfo_sgd
      response('{"accNo":1234,"btcBal":"23.00000000","btcDeposit":"1FkrHkVAFg5Jn3s2njdnWFcbizMYbb423W","email":"goondoo@hotmail.com","error":0,"sgdBal":"57.50"}')
    end

    def getaccinfo_sek
      response('{"accNo":1234,"btcBal":"23.00000000","btcDeposit":"1FkrHkVAFg5Jn3s2njdnWFcbizMYbb423W","email":"goondoo@hotmail.com","error":0,"sekBal":"57.50"}')
    end

    def getorderhistory
      response('{"error":0,"orders":[{"date_created":1387971414,"date_executed":1387971414,"price":"S$3.00","qty":"2.00000000BTC","status":"A","ticket":11,"type":"B"},{"date_created":1387971314,"date_executed":1387971414,"price":"S$3.00","qty":"2.00000000BTC","status":"F","ticket":6,"type":"S"},{"date_created":1387971414,"date_executed":1387971414,"price":"S$5.00","qty":"1.00000000BTC","status":"A","ticket":12,"type":"B"},{"date_created":1387971306,"date_executed":1387971414,"price":"S$5.00","qty":"1.00000000BTC","status":"F","ticket":5,"type":"S"},{"date_created":1387971398,"date_executed":1387971398,"price":"S$2.50","qty":"1.00000000BTC","status":"F","ticket":10,"type":"B"},{"date_created":1387971335,"date_executed":1387971398,"price":"S$2.50","qty":"1.00000000BTC","status":"F","ticket":8,"type":"S"}]}')
    end
  end
end
