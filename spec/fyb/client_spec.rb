require 'spec_helper'

describe Fyb::Client do
  let(:client) { Fyb::Client.new }

  context 'ticker' do
    before { Fyb.stub_chain(:public, :ticker, :perform).and_return JsonData.ticker }

    describe '#ask' do
      subject { client.ask }

      it { should eq 3500 }
    end

    describe '#bid' do
      subject { client.bid }

      it { should eq 3600 }
    end
  end

  describe '#orderbook' do
    before { Fyb.stub_chain(:public, :orderbook, :perform).and_return JsonData.orderbook }
    subject { client.orderbook }

    it { should include 'asks' }
    it { should include 'bids' }
  end

  describe '#trades' do
    before { Fyb.stub_chain(:public, :trades, :perform).and_return JsonData.trades }
    subject { client.trades }

    context 'with since' do
      subject { client.trades Time.now.to_i - 100 }
    end

    context 'without since' do
      it { should be_an_instance_of Array }
    end
  end

  describe '#test' do
    subject { client.test }

    context 'when successful authorization' do
      before { Fyb.stub_chain(:private, :test, :perform).and_return JsonData.test_success }

      it { should be_true }
    end

    context 'when failed authorization' do
      before { Fyb.stub_chain(:private, :test, :perform).and_return JsonData.test_fail }

      it { should be_false }
    end
  end

  context 'order' do
    before { Fyb.stub_chain(:private, :placeorder, :perform).and_return JsonData.order }

    context 'buy! returns order' do
      subject { client.buy!(0.11, 1234) }

      it { should be_an_instance_of Fyb::Order }
    end

    context 'sell! returns order' do
      subject { client.sell!(0.11, 1234) }

      it { should be_an_instance_of Fyb::Order }
    end
  end

  describe '#balance' do
    before { Fyb.stub_chain(:private, :getaccinfo, :perform).and_return JsonData.getaccinfo_sek }
    subject { client.balance }

    it { should include :btc }

    context 'currency = :sek' do
      before { Fyb::Configuration.currency = :sek }

      it { should include :sek }
    end

    context 'currency = :sgd' do
      before do
        Fyb.stub_chain(:private, :getaccinfo, :perform).and_return JsonData.getaccinfo_sgd
        Fyb::Configuration.currency = :sgd
      end

      it { should include :sgd }
    end
  end

  describe '#order_history' do
    before { Fyb.stub_chain(:private, :getorderhistory, :perform).and_return JsonData.getorderhistory }
    subject { client.order_history }

    it { should be_an_instance_of Array }
  end
end
