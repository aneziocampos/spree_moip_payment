Factory.define :moip_payment, :parent => :payment do |record|
  record.association(:order, factory: :moip_order)
end
