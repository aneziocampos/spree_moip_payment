FactoryGirl.define do
  factory :moip, :class => Spree::PaymentMethod::Moip, :parent => :payment_method do
    name 'Moip'
  end
end