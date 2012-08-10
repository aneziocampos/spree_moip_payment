module Moipr
  class Configuration
    attr_accessor :url, :secret_key, :secret_token
  end

  class << self
    attr_accessor :configuration
  end

  def self.setup
    self.configuration ||= Configuration.new
    yield configuration
  end
end