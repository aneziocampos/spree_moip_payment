module Spree
  class PaymentMethod::Moip < PaymentMethod
    preference :moip_token, :string
    preference :moip_key, :string
    preference :currency, :string, :default => 'BRL'
    preference :moip_environment, :string, :default => "Test"

    attr_accessible :preferred_moip_token, :preferred_moip_key, :preferred_currency, :preferred_moip_environment
    
    def provider_class
      Spree::MoipPayment
    end

    def payment_source_class
      nil
    end

    def actions
      %w{capture void}
    end

    # Indicates whether its possible to capture the payment
    def can_capture?(payment)
      ['checkout', 'pending'].include?(payment.state)
    end

    # Indicates whether its possible to void the payment.
    def can_void?(payment)
      payment.state != 'void'
    end

    def capture(*args)
      ActiveMerchant::Billing::Response.new(true, "", {}, {})
    end

    def void(*args)
      ActiveMerchant::Billing::Response.new(true, "", {}, {})
    end

    def source_required?
      false
    end
  end
end
