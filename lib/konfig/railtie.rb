require 'konfig'
require 'rails'

module Konfig
  class InitializeKonfig < Rails::Railtie
    initializer "initialize_konfig.configure_rails_initialization" do

      path = File.join(Rails.root, "config", "settings")
      Konfig.load_directory(path)

      begin
        c = Konfig[:email][:smtp][Rails.env]
        ActionMailer::Base.smtp_settings = c.symbolize_keys
      rescue
      end

    end
  end
end
