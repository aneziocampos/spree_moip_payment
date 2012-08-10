class AddMoipTokenToSpreeOrder < ActiveRecord::Migration
  def change
    change_table :spree_orders do |t|
      t.string :moip_token
    end
  end
end
