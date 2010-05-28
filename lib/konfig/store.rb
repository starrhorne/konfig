require 'active_support/hash_with_indifferent_access'
require 'active_support/core_ext/hash/indifferent_access'
require 'yaml'

module Konfig

  class Store

    def initialize
      @data = HashWithIndifferentAccess.new
    end

    # Loads all yml files in a directory into this store
    # Will not recurse into subdirectories.
    # @param [String] path to directory
    def load_directory(path)

      unless File.directory?(path)
        raise "Konfig couldn't load because it was unable to access #{ path }. Please make sure the directory exists and has the correct permissions."
      end

      Dir[File.join(path, "*.yml")].each { |f| load_file(f) }
    end

    # Loads a single yml file into the store
    # @param [String] path to file
    def load_file(path)
      d = YAML.load_file(path)

      if d.is_a?(Hash) 
        d = HashWithIndifferentAccess.new(d)
        e = Evaluator.new(d)
        d = process(d, e)
      end

      @data[File.basename(path, ".yml").downcase] = d
    end

    # Hash-style access to data
    # @param [String, Symbol] key
    def [](key)
      @data[key]
    end

    def inspect
      @data.inspect
    end

    protected 

      def process(piece, evaluator)
        piece.each do |k, v|
          if v.is_a?(Hash)
            piece[k] = process(v, evaluator) 
          elsif v.is_a?(String) && v.strip =~ /\A`(.*)`\z/
            piece[k] = evaluator.run($1)
          end
        end
        piece
      end


  end

end
