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
        end if attributes
        build_predicate_method
      end

      def status
        STATUS_DE_PAGAMENTO[self.status_pagamento]
      end

      private
      def build_predicate_method
        Moipr::NASP::STATUS_DE_PAGAMENTO.each do |id, value|
          self.instance_eval <<-METHOD
            def #{value}?
              self.status_pagamento == "#{id}"
            end
          METHOD
        end
      end
    end
  end
end