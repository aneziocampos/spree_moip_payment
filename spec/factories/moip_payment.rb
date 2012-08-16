Factory.define :moip_payment, :parent => :payment do |record|
  record.association(:order, factory: :moip_order)
  record.association(:payment_method, factory: :moip_payment_method)
end
