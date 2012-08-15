Factory.define :moip_order, parent: :order do |record|
  record.association(:user, factory: :user)
  record.association(:shipping_method, factory: :shipping_method)
  record.association(:bill_address, :factory => :moip_address)
  record.ship_address { |ship_address| Factory(:moip_address) }
  record.bill_address_id do |order|
    order.bill_address.id
  end
end

Factory.define :moip_order_with_totals, parent: :order do |f|
  f.after_create { |order| FactoryGirl.create(:line_item, order: order, price: 10) and order.line_items.reload }
end
