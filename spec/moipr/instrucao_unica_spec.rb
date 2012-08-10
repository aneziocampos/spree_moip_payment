require 'spec_helper'

describe Moipr::InstrucaoUnica do
  let!(:payment) { FactoryGirl.create(:payment) }
  let(:order) { FactoryGirl.create(:moip_order, number: "R033822659", total: 15.00, state: "delivery", user: FactoryGirl.create(:user, email: "johndoe@example.com")) }
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
          instrucao_unica.request.should eq %{<ns1:EnviarInstrucaoUnicaResponse xmlns:ns1=\"http://www.moip.com.br/ws/alpha/\"><Resposta><ID>201208081711279940000000928977</ID><Status>Sucesso</Status><Token>925041T2U0F8J0Q8W1S7D1I1P2K7L9S9E4N0I0G0Z010Q0H0R9Q2L8T9Z7X7</Token></Resposta></ns1:EnviarInstrucaoUnicaResponse>}
        end
      end
    end
  end
end
