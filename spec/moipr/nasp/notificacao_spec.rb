require 'spec_helper'

describe Moipr::NASP::Notificacao do
  describe "initialize" do
    subject { Moipr::NASP::Notificacao.new(post_nasp_params) }

    its(:cod_moip) { should eq "78343"}
    its(:email_consumidor) { should eq "spree@example.com"}
    its(:forma_pagamento) { should eq "73"}
    its(:id_transacao) { should eq "R202161100"}
    its(:parcelas) { should eq "1"}
    its(:status_pagamento) { should eq "4" }
    its(:tipo_pagamento) { should eq "BoletoBancario"}
    its(:valor) { should eq "1399"}
  end

  describe "statuses" do
    let!(:notificacao) { Moipr::NASP::Notificacao.new(post_nasp_params) }

    context "autorizado" do
      it {
        notificacao.stub!(:status_pagamento).and_return("1")
        notificacao.autorizado?.should be_true
      }
    end
    context "iniciado" do
      it {
        notificacao.stub!(:status_pagamento).and_return("2")
        notificacao.iniciado?.should be_true
      }
    end
    context "boleto impresso" do
      it {
        notificacao.stub!(:status_pagamento).and_return("3")
        notificacao.boleto_impresso?.should be_true
      }
    end
    context "concluido" do
      it {
        notificacao.stub!(:status_pagamento).and_return("4")
        notificacao.concluido?.should be_true
      }
    end
    context "cancelado" do
      it {
        notificacao.stub!(:status_pagamento).and_return("5")
        notificacao.cancelado?.should be_true
      }
    end
    context "em analise" do
      it {
        notificacao.stub!(:status_pagamento).and_return("6")
        notificacao.em_analise?.should be_true
      }
    end
    context "estornado" do
      it {
        notificacao.stub!(:status_pagamento).and_return("7")
        notificacao.estornado?.should be_true
      }
    end
  end
end

