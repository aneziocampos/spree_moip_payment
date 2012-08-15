VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :fakeweb
  c.filter_sensitive_data('<MOIP_DEV_KEY>') { ENV["MOIP_DEV_KEY"] }
  c.filter_sensitive_data('<MOIP_DEV_TOKEN>') { ENV["MOIP_DEV_TOKEN"] }
end