module Moipr
  module NASP
    STATUS_DE_PAGAMENTO = {
      "1" => "autorizado",
      "2" => "iniciado",
      "3" => "boleto_impresso",
      "4" => "concluido",
      "5" => "cancelado",
      "6" => "em_analise",
      "7" => "estornado"
    }

    class Notificacao
      attr_accessor :cod_moip, :email_consumidor, :forma_pagamento, :id_transacao,
                    :parcelas,:status_pagamento, :tipo_pagamento, :valor

      def initialize(attributes = {})
        attributes.each do |name, value|
          send("#{name}=", value)
        end
      end
    end
  end
end