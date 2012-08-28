require 'money'

module Spree
  class MoipCallbacksController < Spree::BaseController
    skip_before_filter :verify_authenticity_token

    ssl_required

    def nasp
      @notificacao = Moipr::NASP::Notificacao.new(params.except!(:controller, :action))
      fetch_order_and_payment
      if @order && @notificacao
        @payment.log_entries.create(:details => @notificacao.to_yaml)

        if @notificacao.autorizado? || @notificacao.em_analise?
          @payment.started_processing!
        elsif @notificacao.iniciado? || @notificacao.boleto_impresso?
          @payment.pend!
        elsif @notificacao.concluido? && @notificacao.pagamento_correto?(@order.total)
          @payment.complete!
        elsif @notificacao.cancelado? || @notificacao.estornado?
          @payment.void!
        end
      end
      render :nothing => true
    end

    private
    def fetch_order_and_payment
      @order = Spree::Order.find_by_number(params[:id_transacao])

      if @order
        @payment = @order.payment
      end
    end
  end
end
