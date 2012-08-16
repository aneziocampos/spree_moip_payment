class AddMoipDebitoUrlToSpreeOrder < ActiveRecord::Migration
  def change
    add_column :spree_orders, :moip_debito_url, :text
  end
end
