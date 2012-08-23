Spree::Address.class_eval do

  attr_accessible :address_number, :district

  validates :address_number, :district, presence: true
  validates :zipcode, :format => { :with => /^(\d){5}-(\d){3}$/ }
  validates :phone, :format => { :with => /^\((\d){2}\)(\d){4}-(\d){4,5}$/ }
end