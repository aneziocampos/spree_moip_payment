Factory.define :moip_address, :parent => :address do |record|
  record.firstname 'John'
  record.lastname 'Doe'
  record.address1 'Av. Presidente Vargas'
  record.address2 'Centro'
  record.city "Rio de Janeiro"
  record.association(:state, :factory => :rj_state)
  record.country do |address|
    if address.state
      address.state.country
    else
      address.association(:country)
    end
  end
  record.zipcode '00000-000'
  record.phone '(21)0000-0000'
  record.address_number 65
  record.district "New Hope"
end
