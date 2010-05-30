require 'konfig/child_class_manager'
require 'konfig/evaluator'
require 'konfig/store'
require 'konfig/adapter'

if defined?(::Rails::Railtie)
  require 'konfig/rails/railtie'
end

# Provides a global accessor for configuration. 
# ie. Konfig[:some_key]
module Konfig

  # Creates a default store and loads a directory into it
  # @param [String] path path to a directory with yml files
  def self.load_directory(path)
    @default_store ||= Konfig::Store.new
    @default_store.load_directory(path)
  end

  # Hash-style access to data
  # @param [String, Symbol] key
  def self.[](key)
    if !@default_store
      raise "Konfig default store not set. Call Konfig.load(path) to set one."
    end
    @default_store[key]
  end

  def self.inspect
    (@default_store || self).inspect
  end

  def self.default_store
    @default_store
  end

end
