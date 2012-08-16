Deface::Override.new(:virtual_path => "spree/shared/_order_details",
                     :name => "order_details_debito",
                     :insert_before => "[data-hook='order_details']",
                     :partial => "spree/shared/debito_info")