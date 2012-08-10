class Spree::MoipPayment < ActiveRecord::Base
  has_many :payments, :as => :source

  attr_accessible :source, :source_type, :response_code, :avs_response, :details
 
end
