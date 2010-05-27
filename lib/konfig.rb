require 'konfig/evaluator'
require 'konfig/store'

if defined?(::Rails::Railtie)
  require 'konfig/railtie'
end

module Konfig

  def self.load(path)
    @default_store ||= Konfig::Store.new(path)
  end

  def self.[](key)

    if !@default_store
      raise "Konfig default store not set. Call Konfig.load(path) to set one."
    end

    @default_store[key]
  end

  def self.inspect
    (@default_store || self).inspect
  end

end
