module Moipr
  class InstrucaoUnica
    def initialize(xml)
      @xml = xml
    end

    def request
      RestClient::Request.execute(params)
    end

    private
    def params
      {
        :method => :post,
        :url => Moipr.configuration.url,
        :payload => @xml.build,
        :user => Moipr.configuration.secret_key,
        :password => Moipr.configuration.secret_token,
        :headers => {
          :content_type => :xml,
          :accept => :xml
        }
      }
    end
  end
end
