module Konfig

  # Used by Konfig::Store to evaluate inline code pulled from
  # configuration files.
  class Evaluator

    attr_accessor :data

    # Set up the evaluator
    # @param [Hash] data data to be available inline code
    def initialize(data)
      @data = data
    end

    # Runs a code fragment
    # @param [String] code some valid ruby code
    # @return the results of the eval
    def run(code)
      eval(code, binding)
    end

    # Converts an options-style nested array into a hash
    # for easy name lookup
    # @param [Array] a an array like [['name', 'val']]
    # @return [Hash] a hash like { val => name }
    def names_by_value(a)
      a = @data[a] if a.is_a?(String) || a.is_a?(Symbol)
      Hash[ a.map { |i| i.reverse } ]
    end

  end
end
