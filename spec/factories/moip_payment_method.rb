Factory.define :moip, :class => Spree::PaymentMethod::Moip, :parent => :payment_method do |record|
  record.name 'Moip'
end
