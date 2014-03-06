require 'spec_helper'

describe Fyb::Configuration do
  describe '.configure' do
    context 'default settings' do
      before { Fyb::Configuration.currency = nil }
      its(:currency) { should eq :sek }
    end

    context 'explicit settings' do
      before do
        Fyb::Configuration.configure do |config|
          config.key = 'testkey'
          config.sig = 'testsig'
          config.currency = :test
        end
      end

      its(:key) { should eq 'testkey' }
      its(:sig) { should eq 'testsig' }
      its(:currency) { should eq :test }
    end
  end

  describe '.domain' do
    subject { Fyb::Configuration.domain }

    context ':sek' do
      before { Fyb::Configuration.currency = :sek }

      it { should eq 'https://www.fybse.se/api/SEK/' }
    end

    context ':sgd' do
      before { Fyb::Configuration.currency = :sgd }

      it { should eq 'https://www.fybsg.com/api/SGD/' }
    end

    context ':test' do
      before { Fyb::Configuration.currency = :test }

      it { should eq 'https://fyb.apiary.io/' }
    end
  end
end
