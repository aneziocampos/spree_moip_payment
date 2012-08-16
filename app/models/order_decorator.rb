require 'rest-client'

Spree::Order.class_eval do

  attr_accessible :moip_boleto_url

  state_machine  do
    before_transition :to => 'payment', :do => :generate_moip_token
  end

  def generate_moip_token
    self.create_shipment!
    self.reload
    xml = Moipr::EnviarInstrucaoXML.new(order: self)
    instrucao_unica = Moipr::InstrucaoUnica.new(xml)
    response = instrucao_unica.request

    doc = Nokogiri::XML(response.to_s)
    moip_token = doc.xpath("//Token")[0].content
    update_column(:moip_token, moip_token)
  end
end