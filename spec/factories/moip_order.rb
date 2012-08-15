Factory.define :moip_order, parent: :order do |record|
  record.association(:user, factory: :user)
  record.association(:shipping_method, factory: :shipping_method)
  record.association(:bill_address, factory: :moip_address)
  record.association(:ship_address, factory: :moip_address)
  record.bill_address_id do |order|
    order.bill_address.id
  end
end
