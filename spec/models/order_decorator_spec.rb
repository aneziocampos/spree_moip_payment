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
    let!(:payment) { FactoryGirl.create(:moip_payment) }
    let(:order) { FactoryGirl.create(:moip_order, number: "R033821777", total: 15.00, state: "delivery", user: FactoryGirl.create(:user, email: "johndoe@example.com")) }

    describe "token generation" do
      before do
        VCR.use_cassette('models/order_decorator/generate_moip_token/success') do
          order.next
        end
      end

      it "should status be payment" do
        order.state.should eq("payment")
      end

      it "should generate token" do
        order.moip_token.should eq("X2X0C1Z270F8U1M5A1H4X2I1N3A1C4I3S2Z0U0P0V0K0W050G9S5S2P061J5")
      end
    end

    describe "create shipment" do
      it "should create shipment" do
        order.should_receive(:create_shipment!).twice
        VCR.use_cassette('models/order_decorator/generate_moip_token/success') do
          order.next
        end
      end

      it "should reload the order" do
        order.should_receive(:reload).once
        VCR.use_cassette('models/order_decorator/generate_moip_token/success') do
          order.next
        end
      end
    end
  end
end