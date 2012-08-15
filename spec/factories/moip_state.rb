Factory.define :rj_state, :parent => :state do |record|
  record.name 'Rio de Janeiro'
  record.abbr 'RJ'
  record.country { |country| country.association(:country) }
end
