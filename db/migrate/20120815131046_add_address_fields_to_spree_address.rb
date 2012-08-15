class AddAddressFieldsToSpreeAddress < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :address_number, :string
    add_column :spree_addresses, :district, :string
  end
end
