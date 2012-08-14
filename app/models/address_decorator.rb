Spree::Address.class_eval do
  validates :zipcode, :format => { :with => /^(\d){5}-(\d){3}$/ }
  validates :phone, :format => { :with => /^\((\d){2}\)(\d){4,5}-(\d){4}$/ }
end