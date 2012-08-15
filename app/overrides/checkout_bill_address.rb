Deface::Override.new(:virtual_path => "spree/checkout/_address",
                     :name => "checkout_bill_address",
                     :insert_before => "#bzipcode",
                     :partial => "spree/checkout/bill_address_fields")