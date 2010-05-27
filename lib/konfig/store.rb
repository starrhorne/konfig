module Konfig

  class Store

    def initialize(path)

      @data = HashWithIndifferentAccess.new

      unless File.directory?(path)
        raise "Konfig couldn't load because it was unable to access #{ path }. Please make sure the directory exists and has the correct permissions."
      end

      Dir[File.join(path, "*.yml")].each { |f| load(f) }

    end

    def load(path)
      d = YAML.load_file(path)

      if d.is_a?(Hash) 
        d = HashWithIndifferentAccess.new(d)
        e = Evaluator.new(d)
        d = process(d, e)
      end

      @data[File.basename(path, ".yml").downcase] = d
    end

    def process(piece, evaluator)
      piece.each do |k, v|
        if v.is_a?(Hash)
          piece[k] = process(v, evaluator) 
        elsif v.is_a?(String) && v.strip =~ /\A<<(.*)\z/
          piece[k] = evaluator.run($1)
        end
      end
      piece
    end

    def [](key)
      @data[key]
    end

    def inspect
      @data.inspect
    end

  end

end
