require 'spec_helper'

describe Spree::MoipCallbacksController do
  describe "POST nasp" do
    let!(:moip) { FactoryGirl.create(:moip_payment_method) }
    let!(:order) { FactoryGirl.create(:moip_order, number: "R033822677", state: "delivery", user: FactoryGirl.create(:user, email: "jj@example.com")) }
    let!(:payment) { FactoryGirl.create(:moip_payment, order: order) }

    context "autorizado" do
      it {
        payment.update_column(:state, "checkout")
        expect {
          post :nasp, post_nasp_params.merge!(status_pagamento: "1", id_transacao: order.number, valor: order.total)
        }.to change{order.reload.payment.state}.from("checkout").to("processing")
      }
    end
    context "iniciado" do
      it {
        payment.update_column(:state, "checkout")
        expect {
          post :nasp, post_nasp_params.merge!(status_pagamento: "2", id_transacao: order.number, valor: order.total)
        }.to change{order.reload.payment.state}.from("checkout").to("pending")
      }
    end
    context "boleto_impresso" do
      it {
        payment.update_column(:state, "checkout")
        expect {
          post :nasp, post_nasp_params.merge!(status_pagamento: "3", id_transacao: order.number, valor: order.total)
        }.to change{order.reload.payment.state}.from("checkout").to("pending")
      }
    end
    context "concluido" do
      context "com valor correto" do
        it {
          expect {
            post :nasp, post_nasp_params.merge!(status_pagamento: "4", id_transacao: order.number, valor: order.total)
          }.to change{order.reload.payment.state}.from("pending").to("completed")
        }
      end
      context "com valor incorreto" do
        it {
          expect {
            post :nasp, post_nasp_params.merge!(status_pagamento: "4", id_transacao: order.number, valor: "199")
          }.to_not change{order.reload.payment.state}
        }
      end
    end
    context "cancelado" do
      it {
        expect {
          post :nasp, post_nasp_params.merge!(status_pagamento: "5", id_transacao: order.number, valor: order.total)
        }.to change{order.reload.payment.state}.from("pending").to("void")
      }
    end
    context "em_analise" do
      it {
        payment.update_column(:state, "checkout")
        expect {
          post :nasp, post_nasp_params.merge!(status_pagamento: "6", id_transacao: order.number, valor: order.total)
        }.to change{order.reload.payment.state}.from("checkout").to("processing")
      }
    end
    context "estornado" do
      it {
        expect {
          post :nasp, post_nasp_params.merge!(status_pagamento: "7", id_transacao: order.number, valor: order.total)
        }.to change{order.reload.payment.state}.from("pending").to("void")
      }
    end
  end
end
