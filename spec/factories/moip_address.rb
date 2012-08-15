Factory.define :moip_address, :parent => :address do |f|
  f.firstname 'John'
  f.lastname 'Doe'
  f.address1 'Av. Presidente Vargas'
  f.address2 'Centro'
  f.city   "Rio de Janeiro"
  f.association(:state, :factory => :rj_state)
  f.country do |address|
    if address.state
      address.state.country
    else
      address.association(:country)
    end
  end
  f.zipcode '20000-000'
  f.phone '(21)0000-0000'
  f.address_number 65
  f.district "New Hope"
end
