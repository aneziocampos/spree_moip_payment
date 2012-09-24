# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_moip_payment'
  s.version     = '1.2.0'
  s.summary     = 'spree_moip_payment criar um Payment Method do MoIP no "spree way" para ser usado em uma loja Spree.'
  # s.description = 'TODO: Add (optional) gem description here'
  s.required_ruby_version = '>= 1.8.7'

  s.authors   = ['Mauro George', 'Rodrigo Pinto']
  s.email     = 'rodrigopqn@gmail.com'
  s.homepage  = 'http://github.com/Helabs/spree_moip_payment'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.2.0'
  s.add_dependency 'rest-client', '1.6.7'

  s.add_development_dependency 'capybara', '1.0.1'
  s.add_development_dependency 'factory_girl', '~> 2.6.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',   '~> 2.9'
  s.add_development_dependency 'pry',           '0.9.10'
  s.add_development_dependency 'awesome_print', '1.0.2'
  s.add_development_dependency 'vcr',           '2.2.4'
  s.add_development_dependency 'shoulda-matchers', '1.2.0'
  s.add_development_dependency 'fakeweb',       '1.3.0'
  s.add_development_dependency 'sqlite3'
end
