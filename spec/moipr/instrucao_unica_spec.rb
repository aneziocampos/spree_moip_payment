require 'spec_helper'

describe Moipr::InstrucaoUnica do
  let!(:payment) { FactoryGirl.create(:moip_payment) }
  let(:order) { FactoryGirl.create(:moip_order, number: "R733822657", total: 15.00, state: "delivery", user: FactoryGirl.create(:user, email: "johndoe@example.com")) }
  let(:instrucao_unica_xml) { Moipr::EnviarInstrucaoXML.new(order: order) }

  describe "#request" do
    let(:instrucao_unica) {  Moipr::InstrucaoUnica.new(instrucao_unica_xml) }

    context "valid attributes" do
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

      it "should get success on request" do
        VCR.use_cassette('moipr/instrucao_unica/request/success') do
          instrucao_unica.request.should eq %{<ns1:EnviarInstrucaoUnicaResponse xmlns:ns1=\"http://www.moip.com.br/ws/alpha/\"><Resposta><ID>201208151434234300000000952051</ID><Status>Sucesso</Status><Token>N2F0Z1P2Q0G8F1E5Z1N4R3Y432W324F3O0U0C0N070S0I0A0P9E5D2M0M531</Token></Resposta></ns1:EnviarInstrucaoUnicaResponse>}
        end
      end
    end
  end
end
