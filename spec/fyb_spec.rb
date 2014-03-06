require 'spec_helper'

describe Fyb do
  describe 'version' do
    subject { Fyb::VERSION }

    it { should_not be_nil }
  end

  describe BigDecimal do
    describe '#btc' do
      subject { BigDecimal('.11111111').btc }

      it { should eq '0.11111111' }
    end

    describe '#money' do
      subject { BigDecimal('3500').money }

      it { should eq '3500.0' }
    end

    describe '#in_money' do
      subject { BigDecimal('2.0').in_money(1000) }

      it { should eq BigDecimal('2000') }
    end
  end
end
