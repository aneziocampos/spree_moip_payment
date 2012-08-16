Factory.define :moip_payment_method, :class => Spree::PaymentMethod::Moip, :parent => :payment_method do |record|
  record.name 'Moip'
  record.environment 'test'
end
