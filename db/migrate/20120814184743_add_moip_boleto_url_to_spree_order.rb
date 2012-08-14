class AddMoipBoletoUrlToSpreeOrder < ActiveRecord::Migration
  def change
    change_table :spree_orders do |t|
      t.text :moip_boleto_url
    end
  end
end
