class AddAddressFieldsToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :address_number, :string
    add_column :spree_orders, :district, :string
  end
end
