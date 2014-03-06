require 'spec_helper'

describe Fyb do
  it 'should have a version number' do
    Fyb::VERSION.should_not be_nil
  end

  before :each do
    Fyb::Configuration.configure do |c|
      c.currency = :test
      c.key = '12LsadXoisadfondfd'
      c.sig = '1245454545'
    end

    response = Weary::Response.new('{"ask":3500.00,"bid":3600.00}',
                                   200,
                                   'Content-Type' => 'application/json')
    Fyb.stub_chain(:public, :ticker, :perform).and_return(response)
  end

  it 'should use the correct domains' do
    Fyb::Configuration.currency = :sek
    Fyb::Configuration.domain.should eq 'https://www.fybse.se/api/SEK/'

    Fyb::Configuration.currency = :sgd
    Fyb::Configuration.domain.should eq 'https://www.fybsg.com/api/SGD/'

    Fyb::Configuration.currency = :test
    Fyb::Configuration.domain.should eq 'https://fyb.apiary.io/'
  end

  it 'should have a ticker with ask and bid' do
    Fyb.ask.should eq 3500.00
    Fyb.bid.should eq 3600.00
  end

  it 'should test private api authorization' do
    p Fyb::Configuration.domain
    Fyb.test.should be_true
  end
end
