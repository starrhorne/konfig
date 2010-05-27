require 'konfig'
require 'rails'

module Konfig
  class InitializeKonfig < Rails::Railtie
    initializer "initialize_konfig.configure_rails_initialization" do
      path = File.join(RAILS_ROOT, "config", "settings")
      Konfig.load(path)
    end
  end
end
