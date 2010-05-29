require 'konfig'
require 'rails'


module Konfig
  class InitializeKonfig < Rails::Railtie
    initializer "initialize_konfig.configure_rails_initialization" do

      path = File.join(Rails.root, "config", "settings")
      Konfig.load_directory(path)

      # Require all adapters
      Dir[File.join(File.dirname(__FILE__), 'adapters', '*.rb')].each do |file| 
        require file
      end

      # Dir[File. + '/adapters/*.rb'].each do |file| 

      Adapter.create_and_send_to_children :adapt, Konfig
    
    end
  end
end
