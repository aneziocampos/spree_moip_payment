require 'spec_helper'

describe Moipr::NASP::Notificacao do
  describe "initialize" do
    subject { Moipr::NASP::Notificacao.new(params) }

    its(:cod_moip) { should eq "78343"}
    its(:email_consumidor) { should eq "spree@example.com"}
    its(:forma_pagamento) { should eq "73"}
    its(:id_transacao) { should eq "R202161100"}
    its(:parcelas) { should eq "1"}
    its(:status_pagamento) { should eq "4" }
    its(:tipo_pagamento) { should eq "BoletoBancario"}
    its(:valor) { should eq "1399"}
  end

  def params(attrs={})
    {
      cod_moip: "78343",
      email_consumidor: "spree@example.com",
      forma_pagamento: "73",
      id_transacao: "R202161100",
      parcelas: "1",
      status_pagamento: "4",
      tipo_pagamento: "BoletoBancario",
      valor: "1399"
    }.merge!(attrs)
  end
end

