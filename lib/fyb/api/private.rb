module Fyb
  module API
    # ==== The private API
    #
    # You can use this directly instead of Fyb::Client if you want.
    #
    # ==== Examples
    #
    #   body = Fyb.private.test.perform.parse
    #
    #   order = Fyb.private.placeorder(:qty => 1.5, :price => 100, 'B').perform.parse
    class Private < Weary::Client
      use Middleware::Timestamper
      use Middleware::Authorize
      use Middleware::Parser

      domain Fyb::Configuration.domain
      headers 'Content-Type' => 'application/x-www-form-urlencoded'

      # This is a hack to let the RACK middleware add a timestamp.
      optional :timestamp

      post :test, 'test'
      post :getaccinfo, 'getaccinfo'
      post :getpendingorders, 'getpendingorders'

      post :getorderhistory, 'getorderhistory' do |resource|
        resource.required :limit
      end

      post :cancelpendingorder, 'cancelpendingorder' do |resource|
        resource.required :orderNo
      end

      post :placeorder, 'placeorder' do |resource|
        resource.required :qty, :price, :type
      end
    end
  end
end
