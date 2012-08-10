Factory.define :moip_address, :parent => :address do |f|
  f.firstname 'John'
  f.lastname 'Doe'
  f.address1 'Av. Presidente Vargas'
  f.address2 'Centro'
  f.city   "Rio de Janeiro"
  f.state  { |state| state.association(:rj_state) }
  f.zipcode '20000-000'
  f.country { |country| country.association(:country) }
  f.phone '21 0000 0000'
end
