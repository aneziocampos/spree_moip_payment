Factory.define :moip_payment, :parent => :payment do |record|
  record.order { FactoryGirl.create(:moip_order) }
end
