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

        if @notificacao.concluido? && @order.total.to_s == format(@notificacao.valor)
          @payment.complete!
        elsif @notificacao.cancelado? || @notificacao.estornado?
          @payment.void!
        end
      end
      render :nothing => true
    end

    private
    def format(number)
      return unless number
      number = number.to_i
      numeral = number/100
      cents = number%100
      [numeral, cents].join(".")
    end

    def fetch_order_and_payment
      @order = Spree::Order.find_by_number(params[:id_transacao])

      if @order
        @payment = @order.payment
      end
    end
  end
end
