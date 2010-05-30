
module Konfig

  # All adapters are subclassed from Konfig::Adapter
  class Adapter

    attr_reader :data

    def initialize(data)
      @data = data
    end

    class << self

      def inherited(child_class)
        children << child_class
      end

      # Get all child classes
      # @return [Array] an array of child classes
      def children
        @children ||= []
      end

      # Remove child classes from registry
      def clear_children
        @children = []
      end

      # Instanciates all child classes
      # @return [Array] Instances of all child classes
      def create_child_instances(data)
        @child_instances = children.map { |c| c.new(data) }
      end

      # Invoke 'send' on all child instances
      # @param params Parameters for 'send'
      def send_to_child_instances(*params)
        @child_instances.each { |c| c.send(*params) }
      end

      # Instanciates all child classes
      # @return [Array] Instances of all child classes
      def child_instances
        @child_instances || []
      end

    end
  end
end
