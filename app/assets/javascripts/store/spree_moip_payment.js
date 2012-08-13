$(document).ready(function(){
  $("input[name='payment_type']").bind('change', function(e){
    $("input[name='payment_type']").each(function(){
      var div_id = $(this).val();
      $('#'+div_id).toggle();
    })
  });

   $("#checkout_form_payment input[type=submit]").click(function(e){
     processaPagtoCredito(this);
     e.preventDefault();
   });

   $('<div />', {
     id: "error_explanation",
   }).prependTo("#moip-payment").hide();

   $('<div />', {
     id: "message",
     class: "flash notice",
   }).prependTo("#moip-payment").hide();
});


function processaPagtoCredito() {
  form = $("#moip-payment");
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

var funcao_sucesso = function(data){
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
