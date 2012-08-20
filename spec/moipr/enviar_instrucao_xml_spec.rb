require 'spec_helper'

describe Moipr::EnviarInstrucaoXML do
  describe "#build" do
    context "order filled" do
      let(:order) { FactoryGirl.create(:moip_order, number: "R033822637", user: FactoryGirl.create(:user, email: "johndoe@example.com")) }
      let(:instrucao_unica) { Moipr::EnviarInstrucaoXML.new(order: order) }

      it "should build a instrucao unica xml" do
        instrucao_unica.build.should == %{<EnviarInstrucao><InstrucaoUnica TipoValidacao=\"Transparente\"><Razao>Loja Fitnoss</Razao><IdProprio>R033822637</IdProprio><Valores><Valor moeda=\"BRL\">0.0</Valor></Valores><Pagador><Nome>John Doe</Nome><Email>johndoe@example.com</Email><IdPagador>1</IdPagador><EnderecoCobranca><Logradouro>Av. Presidente Vargas</Logradouro><Numero>65</Numero><Complemento>Centro</Complemento><Bairro>New Hope</Bairro><Cidade>Rio de Janeiro</Cidade><Estado>RJ</Estado><Pais>BRA</Pais><CEP>00000-000</CEP><TelefoneFixo>(21)0000-0000</TelefoneFixo></EnderecoCobranca></Pagador></InstrucaoUnica></EnviarInstrucao>}
      end
    end
  end
end
