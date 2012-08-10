require 'spec_helper'

describe Moipr::Configuration do
  describe 'when no url is specified' do
    before do
      Moipr.setup do |config|
      end
    end

    it 'defaults to nil' do
      Moipr.configuration.url.should be_nil
    end
  end

  describe 'when a custom url is specified' do
    before do
      Moipr.setup do |config|
        config.url = "http://urlexample.com"
      end
    end

    after do
      Moipr.setup do |config|
        config.url = nil
      end
    end

    it 'is used instead of User' do
      Moipr.configuration.url.should == "http://urlexample.com"
    end
  end
end