//= require maskedinput

$(document).ready(function(){
  $(".moip_payment").hide();
  $("input[name='payment_type']").change(function(){
    var payment_selected = $(this).val();
    $(".moip_payment").hide();
    $("#" + payment_selected).show();
  });

   $("#checkout_form_payment input[type=submit]").click(function(e){
     processaPagamento();
     e.preventDefault();
   });

   $('<div />', {
     id: "error_explanation",
   }).prependTo("#cartao_de_credito").hide();

   $('<div />', {
     id: "message",
     class: "flash notice",
   }).prependTo("#cartao_de_credito").hide();

   generateMoipFields();

   jQuery.validator.addMethod("zipcode", function(value, element) {
     return value.match(/^(\d){5}-(\d){3}$/);
   }, "Defina o Codigo Postal no formato xxxxx-xxx");

   jQuery.validator.addMethod("phone", function(value, element) {
     return value.match(/^\((\d){2}\)(\d){4}-(\d){4,5}_?$/);
   }, "Defina o Telefone no formato (xx)xxxx-xxxx");

   $("#order_bill_address_attributes_zipcode, #order_ship_address_attributes_zipcode").addClass("zipcode");
   $("#order_bill_address_attributes_phone, #order_ship_address_attributes_phone").addClass("phone");
   $("#order_bill_address_attributes_address_number, #order_bill_address_attributes_district").addClass("required");
   $("#order_ship_address_attributes_address_number, #order_ship_address_attributes_district").addClass("required");

   $("#order_bill_address_attributes_zipcode, #order_ship_address_attributes_zipcode").mask("99999-999");
   $("#order_bill_address_attributes_phone, #order_ship_address_attributes_phone").mask("(99)9999-9999?9");
});


function processaPagamento(){
  var selected = $("input[name='payment_type']:checked").val();
  switch(selected) {
    case "boleto":
      processaPagtoBoleto();
     break;
    case "cartao_de_credito":
      processaPagtoCredito();
      break;
    case "debito":
      processaPagtoDebito();
      break;
  }
}

function processaPagtoCredito() {
  form = $("#cartao_de_credito");
   var settings = {
       "Forma": "CartaoCredito",
       "Instituicao": $(form).find("input[name=instituicao]:checked").val(),
       "Parcelas": "1",
       "Recebimento": "AVista",
       "CartaoCredito": {
           "Numero": $(form).find("input[name=numero]").val(),
           "Expiracao": $(form).find("input[name=expiracao]").val(),
           "CodigoSeguranca": $(form).find("input[name=codigo_seguranca]").val(),
           "Portador": {
               "Nome": $(form).find("input[name=nome]").val(),
               "DataNascimento": $(form).find("input[name=data_nascimento]").val(),
               "Telefone": $(form).find("input[name=telefone]").val(),
               "Identidade": $(form).find("input[name=identidade]").val()
           }
       }
   }
   MoipWidget(settings);
}

function processaPagtoBoleto() {
    var settings = {
        "Forma": "BoletoBancario"
    }
    MoipWidget(settings);
}

function processaPagtoDebito() {
    form = $("#debito");
    var settings = {
        "Forma": "DebitoBancario",
        "Instituicao": form.find("input[name=instituicao]:checked").val()
    }
    MoipWidget(settings);
}

var funcao_sucesso = function(data){
  var selected = $("input[name='payment_type']:checked").val();
  if (selected === "boleto") {
    $("#order_moip_boleto_url").val(data.url);
  }
  if (selected === "debito") {
    $("#order_moip_debito_url").val(data.url);
  }
  $("#checkout_form_payment").submit();
};

var funcao_falha = function(data) {
  $("#error_explanation").html("");

  var error_html = $('<h2 />', {
    text: "Verifique os erros abaixo"
  }).appendTo("#error_explanation");

  error_html += $('<ul />', {
  }).appendTo("#error_explanation");

  $.each(data.reverse(), function(index, key) {
      error_html += $('<li />', {
      html: key["Mensagem"]
      }).prependTo("#error_explanation ul");
  });

  $("#error_explanation").show();
};


function generateMoipFields(){
  $('<p id="baddress_number" class="field"> \
      <label for="order_bill_address_attributes_address_number">Numero</label> \
      <span class="required"> \
        * \
      </span> \
      <br><input type="text" name="order[bill_address_attributes][address_number]" id="order_bill_address_attributes_address_number" class="required"> \
  </p>').insertBefore('#baddress2');

  $('<p id="bdistrict" class="field"> \
    <label for="order_bill_address_attributes_district">Bairro</label> \
    <span class="required"> \
      * \
    </span> \
    <br><input type="text" name="order[bill_address_attributes][district]" id="order_bill_address_attributes_district" class="required"> \
  </p>').insertBefore('#bzipcode');

  $('<p id="saddress_number" class="field"> \
    <label for="order_ship_address_attributes_address_number">Numero</label> \
    <span class="required"> \
      * \
    </span> \
    <br><input type="text" name="order[ship_address_attributes][address_number]" id="order_ship_address_attributes_address_number" class="required"> \
  </p>').insertBefore('#saddress2');

  $('<p id="sdistrict" class="field"> \
    <label for="order_ship_address_attributes_district">Bairro</label> \
    <span class="required"> \
      * \
    </span> \
    <br><input type="text" name="order[ship_address_attributes][district]" id="order_ship_address_attributes_district" class="required"> \
  </p>').insertBefore('#szipcode');
}