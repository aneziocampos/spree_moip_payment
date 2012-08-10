class CreateSpreeMoipPayments < ActiveRecord::Migration
  def change
    create_table :spree_moip_payments do |t|
    	t.string :transaction_id
    	t.decimal :value
    	t.integer :payment_status
    	t.integer	:moip_code
    	t.string :payment_type
    	t.string :customer_email

      t.timestamps
    end
  end
end
