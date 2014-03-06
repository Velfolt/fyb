module Fyb
  module API
    class Private < Weary::Client
      use Middleware::Authorize
      use Middleware::Parser

      domain Fyb::Configuration.domain
      headers 'Content-Type' => 'application/x-www-form-urlencoded'

      required :timestamp
      defaults :timestamp => Time.now.to_i

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
