module Konfig
  class Evaluator

    attr_accessor :data

    def initialize(data)
      @data = data
    end

    def run(code)
      eval(code, binding)
    end

    def names_by_value(a)
      a = @data[a] if a.is_a?(String) || a.is_a?(Symbol)
      Hash[ a.map { |i| i.reverse } ]
    end

  end
end
