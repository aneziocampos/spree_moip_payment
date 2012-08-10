Deface::Override.new(:virtual_path => "spree/layouts/spree_application",
                     :name => "moip_js",
                     :insert_bottom => "head",
                     :partial => "spree/checkout/payment/moip_js")