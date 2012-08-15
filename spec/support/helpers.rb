def post_nasp_params(params={})
  {
    cod_moip: "78343",
    email_consumidor: "spree@example.com",
    forma_pagamento: "73",
    id_transacao: "R202161100",
    parcelas: "1",
    status_pagamento: "4",
    tipo_pagamento: "BoletoBancario",
    valor: "1399"
  }.merge!(params)
end
