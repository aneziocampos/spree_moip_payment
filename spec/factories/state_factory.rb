Factory.define :rj_state, :parent => :state do |f|
  f.name 'Rio de Janeiro'
  f.abbr 'RJ'
  f.country { |country| country.association(:country) }
end
