module Konfig


  # All adapters are subclassed from Konfig::Adapter
  class Adapter

    include ChildClassManager

    attr_reader :data

    def initialize(data)
      @data = data
    end

    class << self

      def has_template(key, options = {})
        if block_given?
          content = yield
        else
          content = options[:file] && File.read(options[:file])
          unless content
            content = options[:content]
            content = adjust_whitespace(content) unless options[:preserve_indentation]
          end
        end
          
        Adapter.templates[key] = content
      end

      def template_for(key)
        Adapter.templates[key] 
      end

      def templates
        @templates ||= HashWithIndifferentAccess.new
      end

      def adjust_whitespace(content)
        content.gsub!(/\t/, "  ")
        adjustment = content.lines.map { |l| l =~ /^( *)\S+$/; $1 && $1.size }.compact.min
        content.lines.map { |l| l =~ /^[ ]{#{ adjustment }}(.*)$/; $1.to_s }.join("\n")
      end

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
