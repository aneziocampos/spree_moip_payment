module SpreeMoipPayment
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def add_javascripts
        append_file 'app/assets/javascripts/store/all.js', "//= require store/spree_moip_payment\n"
      end

      def add_stylesheets
        append_file 'app/assets/stylesheets/store/all.css', "/* *= require store/spree_moip_payment\n*/"
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_moip_payment'
      end

      def copy_initializer
        template "moipr.rb", "config/initializers/moipr.rb"
      end

      def run_migrations
         res = ask 'Would you like to run the migrations now? [Y/n]'
         if res == '' || res.downcase == 'y'
           run 'bundle exec rake db:migrate'
         else
           puts 'Skipping rake db:migrate, don\'t forget to run it!'
         end
      end
    end
  end
end
