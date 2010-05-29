require 'konfig'
require 'rails'


module Konfig

  # @return [String] returns the path where config files are located
  def self.path
    @path = File.join(Rails.root, "config", "settings")
  end

  class InitializeKonfig < Rails::Railtie
    initializer "initialize_konfig.configure_rails_initialization" do

      path = Konfig.path

      if File.directory?(path)
        load_settings(path)
      else
        Rails.logger.warn "[Konfig Warning] Unable to access #{ path }. Please make sure the directory exists and has the correct permissions."
      end
    end

    private

      # Set up the Konfig system
      # @param [String] path the path to the directory containing config files
      def load_settings(path)

        # Load the data files
        Konfig.load_directory(path)

        # Load all adapters
        built_in_adapters = File.join(File.dirname(__FILE__), 'adapters', '*.rb')
        require_all built_in_adapters

        user_adapters = File.join(path, 'adapters', '*_adapter.rb')
        require_all user_adapters

        # Apply the adapters to the data
        Adapter.create_and_send_to_children :adapt, Konfig.default_store.data
      end

      def require_all(path)
        Dir[path].each { |file| require file }
      end

  end
end
