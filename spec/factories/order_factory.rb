Factory.define :moip_order, parent: :order do |record|
  record.association(:user, factory: :user)
  record.association(:shipping_method, factory: :shipping_method)
  record.ship_address { |ship_address| Factory(:moip_address, city: "Rio de Janeiro", zipcode: "00000-000", state_name: "RJ") }
  record.after_create do |order|
    state = Factory(:rj_state)
    order.bill_address = Factory(:moip_address, city: "Rio de Janeiro", zipcode: "00000-000", state_name: "RJ name")
    order.bill_address.update_column(:state_id, state.id)
  end
end

Factory.define :moip_order_with_totals, parent: :order do |f|
  f.after_create { |order| FactoryGirl.create(:line_item, order: order, price: 10) and order.line_items.reload }
end
