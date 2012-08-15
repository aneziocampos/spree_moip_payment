require 'spec_helper'

describe Spree::Order do
  before do
    Moipr.setup do |config|
      config.url = "https://desenvolvedor.moip.com.br/sandbox/ws/alpha/EnviarInstrucao/Unica"
      config.secret_key =   ENV["MOIP_DEV_KEY"]
      config.secret_token = ENV["MOIP_DEV_TOKEN"]
    end
  end

  after do
    Moipr.setup do |config|
      config.url = nil
      config.secret_key = nil
      config.secret_token = nil
    end
  end

  describe "generate_moip_token" do
    let!(:payment) { FactoryGirl.create(:payment) }
    let(:order) { FactoryGirl.create(:moip_order, number: "R033822677", total: 15.00, state: "delivery", user: FactoryGirl.create(:user, email: "johndoe@example.com")) }

    before do
      VCR.use_cassette('models/order_decorator/generate_moip_token/success') do
        order.next
      end
    end

    it "should status be payment" do
      order.state.should eq("payment")
    end

    it "should generate token" do
      order.moip_token.should eq("F2X0F1M2F0G8E0P9H1M7Z4N1F3J7A5Z3M5Y0S0102080X0W0G9Z3W3X518U2")
    end
  end
end