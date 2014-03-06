require 'spec_helper'

describe Fyb::Order do
  before { Fyb.stub_chain(:private, :placeorder, :perform).and_return JsonData.order }
  let(:order) { Fyb::Order.new 0.11, 100, :buy }

  describe '#qty_after_fee' do
    subject { order.qty_after_fee }

    it { should eq BigDecimal('0.10912') }
  end

  describe '#money_after_fee' do
    subject { order.money_after_fee }

    it { should eq BigDecimal('10.912') }
  end

  describe '#perform' do
    subject { order.perform }

    its(:order_id) { should eq 28 }
  end

  describe '#cancel!' do
    before { Fyb.stub_chain(:private, :cancelpendingorder, :perform).and_return JsonData.cancelpendingorder }
    subject { order.cancel! }

    context 'pending' do
      subject { order.perform }

      it { should be_true }
    end

    context 'not pending' do
      it { should be_false }
    end
  end

  describe '#pending?' do
    before { Fyb.stub_chain(:private, :getpendingorders, :perform).and_return JsonData.getpendingorders }

    context 'has order_id' do
      subject { order.perform.pending? }
      it { should be_true }
    end

    context 'not pending' do
      subject { order.pending? }
      it { should be_false }
    end
  end
end
