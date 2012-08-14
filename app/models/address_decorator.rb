Spree::Address.class_eval do
  validates :zipcode, :format => { :with => /^(\d){5}-(\d){3}$/ }
end