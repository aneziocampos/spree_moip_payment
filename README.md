SpreeMoipPayment
================

## [WIP] Este projeto está em desenvolvimento e provavelmente não irá funcionar no seu projeto. A base de código atual possui algumas peculiaridades de um projeto específico, porém o objetivo é te-lo refatorado para que qualquer pessoa possa utilizar essa extensão para integrar o MoIP com o Spree.

# O que é spree_moip_payment?
spree_moip_payment, segue o padrão do spree de criar extensões, para criar um Payment Method relacionado ao MoIP na sua aplicação Spree.

## Instalação

Adicione a linha a seguir no Gemfile da sua aplicação:

    gem 'spree_moip_payment', :git => "https://github.com/Helabs/spree_moip_payment.git"

E execute o bundle:

    $ bundle

Depois de instalar a gem, basta executar o install generator:

    $ rails g spree_moip_payment:install

# Como usar?

O comando acima irá gerar as migrações e copiar os arquivos necessários para sua aplicação Spree.
Para que possa começar a usar basta configurar seus dados do MoIP no config/initializers/moipr.rb.


```ruby
Moipr::Config.setup do |config|

  # Url da api do MoIP
  config.url = "https://moip.com.br/ws/alpha/EnviarInstrucao/Unica"

  # Chave de acesso a api do MoIP
  config.secret_key = "Cole seu a chave da sua conta aqui"

  # Token de acesso a api do MoIP
  config.secret_token = "Cole seu o token da sua conta aqui"
end
```

# Quer forkar e testar na sua máquina?? 

Esse projeto está sendo desenvolvido usando ruby 1.9.2. Além do Ruby você precisa de duas variáveis de ambiente configuradas. Que são seusseu secret e seu token do moip labs para rodar sua app.

    export ENV["MOIP_DEV_KEY"]="YOUR-DEVELOPMENT-MOIP-KEY"
    export ENV["MOIP_DEV_TOKEN"]="YOUR-DEVELOPMENT-MOIP-TOKEN"

Enquanto este projeto estiver com o alerta de [WIP] work in progress, pode utilizá-lo por sua conta e risco. ;p esperamos mudar isso o mais rápido possível.

Isso é tudo!

Copyright (c) 2012 [Mauro George, Rodrigo Pinto].
