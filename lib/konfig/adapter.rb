module Konfig


  # All adapters are subclassed from Konfig::Adapter
  class Adapter

    include ChildClassManager

    attr_reader :data

    def initialize(data)
      @data = data
    end

    protected

      def ok(key)
        data[key][:_status] = :ok
        log("Loaded #{key}")
      end

      def error(key)
        data[key][:_status] = :error
        log("Error Loading #{key}")
      end

      def log(message)
        m = "[Konfig] #{ message }"
        defined?(Rails) ?  Rails.logger.info(m) : puts(m)
        m
      end

      def using(key, options={})
        if !data[key]
          raise(log("Required Konfig key #{key} is missing")) if options[:required]
          return
        end

        yield(data[key])
        ok(key) unless data[key][:_status]
      end



  end
end
